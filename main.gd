extends Control

var held_object = null
var player_city = null

func _ready():
	player_city = find_node("PlayerCity")
	
	generate_pool()

func _on_dragable_clicked(object):
	if !held_object:
		held_object = object
		held_object.get_node("Dragable").pickup()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.get_node("Dragable").drop()
			
			if player_city.merge(held_object):
				clear_pool()
				generate_pool()
				
			held_object = null

func _process(_delta):
	# Pass any held object to player's city for check
	if held_object:
		player_city.show_ghost(held_object)
	
func clear_pool():
	for node in get_tree().get_nodes_in_group("dragable"):
		remove_child(node)
	
func generate_pool():
	# TODO: Generate new polyminoes
	
	# Connect signals
	for node in get_tree().get_nodes_in_group("dragable"):
		node.connect("clicked", self, "_on_dragable_clicked")