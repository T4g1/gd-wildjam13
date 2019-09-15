extends Control

var held_object = null
var player_city = null

onready var pool: Pool = $VBoxContainer/Pool
onready var resources_manager: ResourcesManager = $ResourcesManager
onready var timer: ResourcesTimer = $Timer
onready var gui: GUIResources = $GUIResources
onready var doom: Timer = $doom_timer

func _ready():
	player_city = find_node("PlayerCity")
	
	pool.connect("add_polymino", self, "_on_add_polymino")
	pool.connect("remove_polymino", self, "_on_remove_polymino")
	# Connect resource manager to GUI
	resources_manager.connect("updated_resources", gui, "update_resources")
	resources_manager.connect("updated_diffs", gui, "update_diffs")
	
	# Connect resource manager to game_over logic
	resources_manager.connect("is_empty", self, "init_doom")
	doom.connect("timeout", self, "check_doom")
	
	# Connect timer to consume action
	timer.connect("timeout", self, "consume_produce")
	
	start_game()
	
func start_game():
	timer.start()
	resources_manager.reset()
	# Set gui to init values
	gui.update_resources(resources_manager.resources)
	gui.update_population(1)
	
	
	randomize()
	generate_pool()

func _on_dragable_clicked(object):
	if !held_object:
		held_object = object
		held_object.get_node("Dragable").pickup()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			
			if player_city.merge(held_object):
				generate_pool()
			else:
				held_object.get_node("Dragable").drop()
			
			player_city.hide_ghost()
			held_object = null

func _process(_delta):
	# Pass any held object to player's city for check
	if held_object:
		player_city.show_ghost(held_object)
	# Update GUI with timer value
	gui.update_timer(timer.time_left / timer.wait_time)
	
func clear_pool():
	for node in get_tree().get_nodes_in_group("dragable"):
		node.free()
	
func generate_pool():
	pool.generate_new_pool()
	
func _on_add_polymino(polymino: Polymino):
	# Connect signals
	polymino.connect("clicked", self, "_on_dragable_clicked") 
func _on_remove_polymino(polymino: Polymino):
	polymino.disconnect("clicked", self, "_on_dragable_clicked")
	