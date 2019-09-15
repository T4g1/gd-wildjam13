extends HBoxContainer
class_name ResourceLabels

export(StreamTexture) var icon: StreamTexture
export(bool) var no_diff := false

onready var label_total: Label = $Labels/total
onready var label_diff: Label = $Labels/diff

var RED: Color = Color('#ff2626')
var GREEN: Color = Color('#26ff26')
#var GREY: Color = Color('#838383')

func _ready():
	$Icon.texture = icon
	if no_diff:
		$Labels.remove_child(label_diff)

func update_total(value: int):
	label_total.text = str(value)
	if value <= 0:
		label_total.add_color_override("font_color", RED)
	else:
		label_total.add_color_override("font_color", Color(1,1,1))
	
func update_diff(value: int):
	if value > 0:
		label_diff.text = '+' + str(value)
		label_diff.add_color_override('font_color', GREEN)
	elif value < 0:
		label_diff.text = str(value)
		label_diff.add_color_override('font_color', RED)
	else:
		label_diff.text = str('')
