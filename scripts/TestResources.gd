extends Node2D
class_name TestResources

onready var resources_manager: ResourcesManager = $ResourcesManager
onready var timer: ResourcesTimer = $Timer
onready var gui: GUIResources = $GUIResources
onready var doom: Timer = $DoomTimer

var bloc_packed: PackedScene = preload("res://scenes/Bloc.tscn")

func _ready():
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

func _input(event: InputEvent):
	if event.is_action_pressed("ui_left"):
		create_bloc(ResourceType.Types.FOOD)
	if event.is_action_pressed("ui_down"):
		create_bloc(ResourceType.Types.WATER)
	if event.is_action_pressed("ui_right"):
		create_bloc(ResourceType.Types.IRON)
		
func _process(delta):
	# Update GUI with timer value
	gui.update_timer(timer.time_left / timer.wait_time)
		
func create_bloc(type: int):
	# Create Bloc from prefab
	var bloc: Bloc = bloc_packed.instance()
	bloc.prod_type = type
	bloc.active = true
	
	# Connect bloc to resource manager
	bloc.connect("consume", resources_manager, "remove")
	bloc.connect("produce", resources_manager, "add")
	
	# Add bloc in the tree
	$Blocs.add_child(bloc)
	resources_manager.update_diffs()
	
	# Update timer pace and activate a consume cycle
	timer.speed_up()
	consume_produce()
	
	# Increase population
	gui.update_population(1 + get_tree().get_nodes_in_group("bloc").size())

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
		$game_over.visible = true
