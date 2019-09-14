extends Node2D
class_name TestResources

onready var resources_manager: ResourcesManager = $ResourcesManager

var bloc_packed: PackedScene = preload("res://scenes/Bloc.tscn")

func _ready():
  resources_manager.connect("updated_resources", self, "show_resources")
  resources_manager.connect("updated_diffs", self, "show_diffs")

func show_resources(resources: Dictionary):
  print("resources:")
  print(resources)
  
func show_diffs(diffs: Dictionary):
  print("diffs:")
  print(diffs)

func _input(event: InputEvent):
  if event.is_action_pressed("ui_left"):
    create_bloc(ResourcesManager.ResourceType.FOOD)
  if event.is_action_pressed("ui_down"):
    create_bloc(ResourcesManager.ResourceType.IRON)
  if event.is_action_pressed("ui_right"):
    create_bloc(ResourcesManager.ResourceType.WATER)
  
  if event.is_action_pressed("ui_accept"):
    get_tree().call_group("bloc", "consume_and_produce")
    
func create_bloc(type: int):
  var bloc: Bloc = bloc_packed.instance()
  bloc.prod_type = type
  bloc.active = true
  
  bloc.connect("consume", resources_manager, "remove")
  bloc.connect("produce", resources_manager, "add")
  
  $Blocs.add_child(bloc)
  resources_manager.update_diffs()
