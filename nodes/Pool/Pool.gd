extends HBoxContainer
class_name Pool

signal add_polymino
signal remove_polymino

var packed_polymino: PackedScene = preload("res://nodes/Polymino/Polymino.tscn")

var POOL_SIZE := 4

func _ready():
	pass
	
func generate_new_pool():
	# flush
	for c in get_children():
		emit_signal("remove_polymino", c.get_child(0))
		remove_child(c)
		c.queue_free()

	# create new polymino
	for __ in range(0, POOL_SIZE):
		_add_polymino()

func _add_polymino():
	var polymino: Polymino = packed_polymino.instance()
	var control = Control.new()
	add_child(control)
	control.add_child(polymino)
	polymino.set_shape(randi() % Polymino.PolyminoShape.size())
	emit_signal("add_polymino", polymino)
