extends Control

signal add_bloc

const RED = Color(1.0, 0.0, 0.0, 0.5)
const GREEN = Color(0.0, 1.0, 0.0, 0.5)
const BARELY_VISIBLE = Color(1.0, 1.0, 1.0, 0.2)

onready var bloc_scene = preload("res://nodes/Bloc/Bloc.tscn")

export (Vector2) var starting_point = Vector2(0, 0)

func _ready():
	$Ghost.remove_from_group("dragable")

func reset():
	$Grid.flush()
	
	for bloc in $Blocs.get_children():
		bloc.free()
	
	$Grid.set_cell(starting_point.x, starting_point.y, 1)

func show_ghost(polymino):
	var city_size = $Grid.grid_size * $Grid.cell_size
	var polymino_size = polymino.TETROMINO_SIZE * $Grid.cell_size
	var offset = $Grid.rect_position - (city_size / 2) + (polymino_size / 2)
	
	$Ghost.visible = true
	$Ghost.set_shape(polymino.shape)
	$Ghost.position = offset + (get_cell_position(polymino) * $Grid.cell_size)
	
	polymino.modulate = BARELY_VISIBLE
	
	if is_valid_placement(polymino):
		$Ghost.modulate = GREEN
	else:
		$Ghost.modulate = RED

func hide_ghost():
	$Ghost.visible = false

# Merge the given polymino with the player city
# Return false on failed merge and does not modify anything in that case
func merge(polymino: Polymino):
	if is_valid_placement(polymino):
		var cell_position = get_cell_position(polymino)
		
		for x in range(polymino.TETROMINO_SIZE):
			for y in range(polymino.TETROMINO_SIZE):
				var tile = polymino.get_node("Grid").get_cell(x, y)
				if tile != -1:
					# TODO configure tile is set_cell
					$Grid.set_cell(cell_position.x + x, cell_position.y + y, tile)
				
		for b in polymino.get_blocs():
			var bloc := b as Bloc
			$Blocs.add_child(bloc)
			bloc.active = true
			emit_signal("add_bloc", bloc)
			
		return true
	else:
		return false

func is_valid_placement(polymino):
	var cell_position = get_cell_position(polymino)
	
	# Check placement is empty
	var check_pile : Array = []
	var is_empty = true
	for x in range(polymino.TETROMINO_SIZE):
		for y in range(polymino.TETROMINO_SIZE):
			if !polymino.get_node("Grid").is_free(x, y):
				var city_position = Vector2(cell_position.x + x, cell_position.y + y)
				check_pile.append(Vector2(city_position.x,     city_position.y))
				check_pile.append(Vector2(city_position.x + 1, city_position.y))
				check_pile.append(Vector2(city_position.x - 1, city_position.y))
				check_pile.append(Vector2(city_position.x,     city_position.y + 1))
				check_pile.append(Vector2(city_position.x,     city_position.y - 1))
				
				if city_position.x >= 0 and  \
					city_position.x < $Grid.grid_size and \
					city_position.y >= 0 and  \
					city_position.y < $Grid.grid_size:
					is_empty = is_empty and $Grid.is_free(cell_position.x + x, cell_position.y + y)
				else:
					is_empty = false
					break
	
	# Check one adjacent tile is not empty
	var is_adjacent = false
	print(check_pile.size())
	for position in check_pile:
		#print(position)
		if !$Grid.is_free(position.x, position.y):
			is_adjacent = true
			break
	
	if is_adjacent:
		print("neighboor")
	
	return is_empty and is_adjacent

# At which cells over the city is the most upper-left cell of the polymino 
func get_cell_position(polymino):
	# Compute upper left corner position of city (position is in the center of the grid)
	var city_size = $Grid.grid_size * $Grid.cell_size
	var upper_left = get_global_position() - (city_size / 2)
	
	# Compute upper left corner position of polymino (position is in the center of the grid)
	var polymino_size = polymino.TETROMINO_SIZE * $Grid.cell_size
	var polymino_upper_left = polymino.get_global_position() - (polymino_size / 2)
	
	var delta = polymino_upper_left - upper_left
	
	return (delta / $Grid.cell_size).floor()