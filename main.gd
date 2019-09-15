extends Control

var held_object = null

func _ready():
	# TODO: do that when instantiating new polymino to be used
	for node in get_tree().get_nodes_in_group("dragable"):
		node.connect("clicked", self, "_on_dragable_clicked")

func _on_dragable_clicked(object):
	if !held_object:
		held_object = object
		held_object.pickup()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop()
			held_object = null