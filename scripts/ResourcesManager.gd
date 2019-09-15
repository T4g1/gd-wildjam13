extends Node2D
class_name ResourcesManager

signal is_empty
signal updated_resources
signal updated_diffs

var resources: Dictionary = {}
var diffs: Dictionary = {}

export(int) var base = 15

func _ready():
  reset()

func reset():
  for type in range(0, ResourceType.Types.size()):
    resources[type] = base
    diffs[type] = 0

func add(type: int, value: int):
  resources[type] += value
  emit_signal("updated_resources", resources)

func remove(type: int, value: int):
  resources[type] -= value
  if resources[type] < 0:
    emit_signal("is_empty")
  emit_signal("updated_resources", resources)

func update_diffs():
  for type in range(0, ResourceType.Types.size()):
    diffs[type] = 0

  var blocs := get_tree().get_nodes_in_group("bloc")
  for b_i in blocs:
    var bloc := b_i as Bloc
    if bloc.active:
      for type in range(0, ResourceType.Types.size()):
        if type == bloc.prod_type:
          diffs[type] += bloc.production
        else:
          diffs[type] -= bloc.consumption
    
    emit_signal("updated_diffs", diffs)

func is_empty() -> bool:
  var empty = false
  for type in range(0, ResourceType.Types.size()):
    empty = empty || resources[type] < 0
  return empty