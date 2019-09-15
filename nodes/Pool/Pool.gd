extends HBoxContainer
class_name Pool

signal add_polymino
signal remove_polymino

var packed_polymino: PackedScene = preload("res://nodes/Polymino/Polymino.tscn")
var gui_production: PackedScene = preload("res://nodes/GUIProduction/GUIProduction.tscn")

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
	var control = Control.new()
	
	var polymino: Polymino = packed_polymino.instance()
	polymino.set_shape(randi() % Polymino.PolyminoShape.size())
	
	var production = gui_production.instance()
	production.rect_scale = Vector2(0.5, 0.5)
	print(production.rect_size)
	production.rect_position.x = -60
	production.rect_position.y = 35
	# TODO: Compute real values
	production.set_food(4)
	production.set_wood(1)
	production.set_rock(2)
	production.set_gold(0)
	
	add_child(control)
	control.add_child(polymino)
	control.add_child(production)
	
	emit_signal("add_polymino", polymino)
