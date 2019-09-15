tool
extends Node2D
class_name Polymino

signal clicked

const TETROMINO_SIZE = 4
const PATTERN = [
	[[1, 1, 0, 0],	# Z
	 [0, 1, 1, 0],
	 [0, 0, 0, 0],
	 [0, 0, 0, 0]],
	[[0, 1, 1, 0],	# S
	 [1, 1, 0, 0],
	 [0, 0, 0, 0],
	 [0, 0, 0, 0]],
	[[1, 0, 0, 0],	# L
	 [1, 0, 0, 0],
	 [1, 1, 0, 0],
	 [0, 0, 0, 0]],
	[[0, 1, 0, 0],	# J
	 [0, 1, 0, 0],
	 [1, 1, 0, 0],
	 [0, 0, 0, 0]],
	[[1, 1, 0, 0],	# O
	 [1, 1, 0, 0],
	 [0, 0, 0, 0],
	 [0, 0, 0, 0]],
	[[1, 0, 0, 0],	# I
	 [1, 0, 0, 0],
	 [1, 0, 0, 0],
	 [1, 0, 0, 0]],
	[[0, 1, 0, 0],	# W
	 [1, 1, 1, 0],
	 [0, 0, 0, 0],
	 [0, 0, 0, 0]]
]

enum PolyminoShape { Z = 0, S, L, J, O, I, W }
export(PolyminoShape) var shape = PolyminoShape.Z setget set_shape
export(bool) var ghost := false

var bloc_packed: PackedScene = preload("res://nodes/Bloc/Bloc.tscn")

var blocs: Array = []

func set_shape(new_shape):
	if !has_node("Grid"):
		return

	shape = new_shape
	var tiles := []

	for __ in range(0, TETROMINO_SIZE):
		# Create Bloc from prefab
		var bloc: Bloc = bloc_packed.instance()
		var type := randi() % ResourceType.Types.size()
		bloc.prod_type = type
		blocs.push_front(bloc)
		if !ghost:
			tiles.push_front(ResourceType.TYPES_TILES_ID[type])
		else:
			tiles.push_front(8)

	$Grid.set_content(PATTERN[shape], TETROMINO_SIZE, tiles)

func _on_clicked():
	emit_signal("clicked", self)

func get_blocs() -> Array:
	return blocs

func get_production(type):
	var total = 0
	for bloc in blocs:
		if bloc.prod_type == type:
			total += bloc.production
		else:
			total -= 1

	return total

func get_production_food():
	return get_production(ResourceType.Types.FOOD)

func get_production_wood():
	return get_production(ResourceType.Types.WOOD)

func get_production_rock():
	return get_production(ResourceType.Types.ROCK)

func get_production_gold():
	return get_production(ResourceType.Types.GOLD)

