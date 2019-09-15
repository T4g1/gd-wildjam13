extends HBoxContainer
class_name ResourceLabels

export(StreamTexture) var icon: StreamTexture
export(bool) var show_diff := true
export(bool) var show_total := true

var RED: Color = Color('#ff2626')
var GREEN: Color = Color('#26ff26')
var GREY: Color = Color('#838383')

func _ready():
	$Icon.texture = icon

func update_total(value: int):
	var label_total = find_node("total")
	label_total.visible = show_total
	
	label_total.text = str(value)
	if value <= 0:
		label_total.add_color_override("font_color", RED)
	else:
		label_total.add_color_override("font_color", Color(1,1,1))
	
func update_diff(value: int):
	var label_diff = find_node("diff")
	label_diff.visible = show_diff
	
	if value > 0:
		label_diff.text = '+' + str(value)
		label_diff.add_color_override('font_color', GREEN)
	elif value < 0:
		label_diff.text = str(value)
		label_diff.add_color_override('font_color', RED)
	else:
		label_diff.text = str('0')
		label_diff.add_color_override('font_color', GREY)
