extends Control

signal game_over

var score = 0
var held_object = null
var player_city = null
onready var pool: Pool = $VBoxContainer/Pool

func _ready():
	player_city = find_node("PlayerCity")
	
	pool.connect("add_polymino", self, "_on_add_polymino")
	pool.connect("remove_polymino", self, "_on_remove_polymino")
	
	randomize()
	generate_pool()

func _on_dragable_clicked(object):
	if !held_object:
		held_object = object
		held_object.get_node("Dragable").pickup()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			
			if player_city.merge(held_object):
				generate_pool()
			else:
				held_object.get_node("Dragable").drop()
			
			player_city.hide_ghost()
			held_object = null

func _process(_delta):
	# Pass any held object to player's city for check
	if held_object:
		player_city.show_ghost(held_object)
	
func generate_pool():
	pool.generate_new_pool()
	
func _on_add_polymino(polymino: Polymino):
	# Connect signals
	polymino.connect("clicked", self, "_on_dragable_clicked") 
func _on_remove_polymino(polymino: Polymino):
	polymino.disconnect("clicked", self, "_on_dragable_clicked")

func _on_game_over():
	emit_signal("game_over", score)