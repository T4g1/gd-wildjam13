extends Control
class_name GUIResources

onready var population: ResourceLabels = $Container/Population
onready var consume_bar: ConsumeBar = $Container/ConsumeBar
var resources_labels: Dictionary = {}


func _ready():
	resources_labels[ResourceType.Types.FOOD] = $Container/Resources/Food
	resources_labels[ResourceType.Types.WOOD] = $Container/Resources/Wood
	resources_labels[ResourceType.Types.ROCK] = $Container/Resources/Rock
	resources_labels[ResourceType.Types.GOLD] = $Container/Resources/Gold
	
	for type in range(0, ResourceType.Types.size()):
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
		
func update_timer(value: float):
	consume_bar.update_value(value)
