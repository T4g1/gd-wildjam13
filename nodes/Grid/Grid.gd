tool
extends Control

export (int, 4, 100) var grid_size = 15 setget set_grid_size
export (bool) var show_grid = true setget set_visibility

var cell_size = 0

func _ready():
	cell_size = $Lines.cell_size

func set_grid_size(new_grid_size):
	if !has_node("Lines"):
		return
		
	grid_size = new_grid_size
	
	var tileMap_size = grid_size * $Lines.cell_size
	var center_position = Vector2(
		rect_size.x / 2 - tileMap_size.x / 2,
		rect_size.y / 2 - tileMap_size.y / 2
	)
	
	$Lines.position = center_position
	$Content.position = center_position
	
	$Lines.clear()
	$Content.clear()

	for x in range(grid_size):
		for y in range(grid_size):
			$Lines.set_cell(x, y, 0)

func set_visibility(new_value):
	if !has_node("Lines"):
		return
		
	show_grid = new_value
	
	$Lines.visible = show_grid

func flush():
	$Content.clear()

# Takes an array and copies it into the current grid
func set_content(array, size):
	$Content.clear()
	
	for x in range(size):
		for y in range(size):
			$Content.set_cell(x, y, array[y][x])

# Compute how many cells are occupied
func get_size():
	if !has_node("Content"):
		return 0
		
	return $Content.get_used_cells().size()

func get_cell(x, y):
	return $Content.get_cell(x, y)

func set_cell(x, y, value):
	return $Content.set_cell(x, y, value)

func is_free(x, y):
	return $Content.get_cell(x, y) == -1