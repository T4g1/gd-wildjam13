extends Node2D
class_name TestResources

onready var resources_manager: ResourcesManager = $ResourcesManager
onready var timer: ResourcesTimer = $Timer
onready var gui: GUIResources = $GUIResources

var bloc_packed: PackedScene = preload("res://scenes/Bloc.tscn")

func _ready():
  resources_manager.connect("updated_resources", gui, "update_resources")
  resources_manager.connect("updated_diffs", gui, "update_diffs")
  
  timer.connect("timeout", self, "consume_produce")
  timer.start()
  
  gui.update_resources(resources_manager.resources)
  gui.update_population(1)

func _input(event: InputEvent):
  if event.is_action_pressed("ui_left"):
    create_bloc(ResourcesManager.ResourceType.FOOD)
  if event.is_action_pressed("ui_down"):
    create_bloc(ResourcesManager.ResourceType.WATER)
  if event.is_action_pressed("ui_right"):
    create_bloc(ResourcesManager.ResourceType.IRON)
    
func _process(delta):
  gui.update_timer(timer.time_left / timer.wait_time)
    
func create_bloc(type: int):
  var bloc: Bloc = bloc_packed.instance()
  bloc.prod_type = type
  bloc.active = true
  
  bloc.connect("consume", resources_manager, "remove")
  bloc.connect("produce", resources_manager, "add")
  
  $Blocs.add_child(bloc)
  resources_manager.update_diffs()
  
  timer.speed_up()
  consume_produce()
  
  gui.update_population(1 + get_tree().get_nodes_in_group("bloc").size())

func consume_produce():
  get_tree().call_group("bloc", "consume_and_produce")
