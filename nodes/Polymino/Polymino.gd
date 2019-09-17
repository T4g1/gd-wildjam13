tool
extends Node2D
class_name Polymino

signal clicked

const EMPTY_TILE = 8
const TETROMINO_SIZE = 4
const PATTERN = [
	[[0, 0, 0, 0],	# Z
	 [1, 1, 0, 0],
	 [0, 1, 1, 0],
	 [0, 0, 0, 0]],
	[[0, 0, 0, 0],	# S
	 [0, 1, 1, 0],
	 [1, 1, 0, 0],
	 [0, 0, 0, 0]],
	[[0, 1, 0, 0],	# L
	 [0, 1, 0, 0],
	 [0, 1, 1, 0],
	 [0, 0, 0, 0]],
	[[0, 0, 1, 0],	# J
	 [0, 0, 1, 0],
	 [0, 1, 1, 0],
	 [0, 0, 0, 0]],
	[[0, 0, 0, 0],	# O
	 [0, 1, 1, 0],
	 [0, 1, 1, 0],
	 [0, 0, 0, 0]],
	[[0, 1, 0, 0],	# I
	 [0, 1, 0, 0],
	 [0, 1, 0, 0],
	 [0, 1, 0, 0]],
	[[0, 0, 0, 0],	# W
	 [0, 1, 0, 0],
	 [1, 1, 1, 0],
	 [0, 0, 0, 0]]
]

enum PolyminoShape { Z = 0, S, L, J, O, I, W }
export(PolyminoShape) var shape = PolyminoShape.Z setget set_shape
export(bool) var ghost := false

var bloc_packed: PackedScene = preload("res://nodes/Bloc/Bloc.tscn")

var blocs: Array = []
var occupied_position: Array = []
var tiles: Array = [
	[0, 0, 0, 0],
	[0, 0, 0, 0],
	[0, 0, 0, 0],
	[0, 0, 0, 0]
]

func set_shape(new_shape):
	if !has_node("Grid"):
		return
	
	for bloc in blocs:
		bloc.free()
		
	blocs.clear()

	shape = new_shape
	
	# Generate an array with correct value for the tetromino
	tiles = PATTERN[shape].duplicate(true)
	for x in range(TETROMINO_SIZE):
		for y in range(TETROMINO_SIZE):
			if tiles[y][x]:
				# Create Bloc from prefab
				var bloc: Bloc = bloc_packed.instance()
				var type := randi() % ResourceType.Types.size()
				bloc.prod_type = type
				blocs.push_front(bloc)
				
				tiles[y][x] = EMPTY_TILE
				if !ghost:
					tiles[y][x] = ResourceType.TYPES_TILES_ID[type]
			else:
				tiles[y][x] = -1
	
	set_content(tiles)

func set_content(new_tiles):
	tiles = new_tiles.duplicate(true)
	
	occupied_position.clear()
	
	# Generate an array of tiles position used for optimisation of valid placement research 
	for x in range(TETROMINO_SIZE):
		for y in range(TETROMINO_SIZE):
			if tiles[y][x] != -1:
				occupied_position.append(Vector2(x, y))
	
	$Grid.set_content(tiles, TETROMINO_SIZE)

# Rotate 90 degrees clockwise
func clockwise_rotate():
	var old_tiles = tiles.duplicate(true)
	
	for x in range(TETROMINO_SIZE):
		for y in range(TETROMINO_SIZE):
			tiles[x][TETROMINO_SIZE - 1 - y] = old_tiles[y][x]
	
	set_content(tiles)

func _on_clicked():
	emit_signal("clicked", self)

func _on_double_clicked():
	clockwise_rotate()
	
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

