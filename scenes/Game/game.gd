extends Control

signal game_over

var running = false
var held_object = null
var player_city = null

onready var pool: Pool = $VBoxContainer/Pool
onready var resources_manager: ResourcesManager = $ResourcesManager
onready var timer: ResourcesTimer = $Timer
onready var gui: GUIResources = $GUIResources
onready var doom: Timer = $doom_timer

func _ready():
	player_city = find_node("PlayerCity")
	
	var _error = pool.connect("add_polymino", self, "_on_add_polymino")
	_error = pool.connect("remove_polymino", self, "_on_remove_polymino")
	_error = player_city.connect("add_bloc", self, "_on_add_bloc")
	
	# Connect resource manager to GUI
	_error = resources_manager.connect("updated_resources", gui, "update_resources")
	_error = resources_manager.connect("updated_diffs", gui, "update_diffs")
	_error = resources_manager.connect("updated_population", gui, "update_population")
	
	# Connect resource manager to game_over logic
	_error = resources_manager.connect("is_empty", self, "init_doom")
	_error = doom.connect("timeout", self, "check_doom")
	
	# Connect timer to consume action
	_error = timer.connect("timeout", self, "consume_produce")
    
func start_game():
	player_city.reset()
	
	timer.start()
	resources_manager.reset()
	
	# Set gui to init values
	gui.update_resources(resources_manager.resources)
	gui.update_diffs(resources_manager.diffs)
	gui.update_population(resources_manager.population)
	
	randomize()
	generate_pool()
	
	running = true

func _on_dragable_clicked(object):
	if !running:
		return
	
	if !held_object:
		held_object = object
		held_object.get_node("Dragable").pickup()

func _unhandled_input(event):
	if !running:
		return
	
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			if player_city.merge(held_object):
				# Update timer pace and activate a consume cycle
				timer.speed_up()
				consume_produce()
				# Increase population
				resources_manager.update_diffs()
				resources_manager.increase_population(Polymino.TETROMINO_SIZE)
				# new pool
				generate_pool()
			else:
				held_object.get_node("Dragable").drop()
			
			player_city.hide_ghost()
			held_object = null

func _process(_delta):
	if !running:
		return
	
	if held_object:
		player_city.show_ghost(held_object)
		
	gui.update_timer(timer.time_left / timer.wait_time)
    
func clear_pool():
	for node in get_tree().get_nodes_in_group("dragable"):
		node.free()

func generate_pool():
	pool.generate_new_pool()
    
func _on_add_polymino(polymino: Polymino):
	# Connect signals
	var _error = polymino.connect("clicked", self, "_on_dragable_clicked") 

func _on_remove_polymino(polymino: Polymino):
	polymino.disconnect("clicked", self, "_on_dragable_clicked")

func _on_add_bloc(bloc: Bloc):
	# Connect bloc to resource manager
	var _error = bloc.connect("consume", resources_manager, "remove")
	_error = bloc.connect("produce", resources_manager, "add")

func consume_produce():
	# Get all blocs to consume and produce
	get_tree().call_group("bloc", "consume_and_produce")

func init_doom():
	# Start a little timer when a resource drop below 0
	if doom.is_stopped():
		doom.start()

func check_doom():
	# Once the timer is done, if the value is still < 0, stop game
	if resources_manager.is_empty():
		timer.stop()
		_on_game_over()

func _on_game_over():
	running = false
	emit_signal("game_over", resources_manager.population)
