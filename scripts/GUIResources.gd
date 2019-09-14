extends Control
class_name GUIResources

onready var population: ResourceLabels = $Container/Population
var resources_labels: Dictionary = {}


func _ready():
  resources_labels[ResourcesManager.ResourceType.FOOD] = $Container/Resources/Food
  resources_labels[ResourcesManager.ResourceType.WATER] = $Container/Resources/Water
  resources_labels[ResourcesManager.ResourceType.IRON] = $Container/Resources/Iron
  
  for type in range(0, ResourcesManager.ResourceType.size()):
    var resource: ResourceLabels = resources_labels[type]
    resource.update_total(0)
    resource.update_diff(0)
    
  population.update_total(0)

func update_population(value: int):
  population.update_total(value)
  
func update_resources(values: Dictionary):
  for key in values.keys():
    var resource: ResourceLabels = resources_labels[key]
    resource.update_total(values[key])
    
func update_diffs(values: Dictionary):
  for key in values.keys():
    var resource: ResourceLabels = resources_labels[key]
    resource.update_diff(values[key])