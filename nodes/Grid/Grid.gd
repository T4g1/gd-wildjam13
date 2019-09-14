tool
extends Node2D

export (int, 4, 100) var size = 15 setget set_size
export (bool) var show_grid = true setget set_visibility

func set_size(new_size):
	if !has_node("Lines"):
		return
		
	size = new_size
	
	$Lines.clear()
	$Content.clear()

	for x in range(size):
		for y in range(size):
			$Lines.set_cell(x, y, 0)

func set_visibility(new_value):
	if !has_node("Lines"):
		return
		
	show_grid = new_value
	
	$Lines.visible = show_grid

func flush():
	$Content.clear()

# Takes an array and copies it into the current grid
# TODO: Gives tiles instead of boolean
func set_content(array, size):
	$Content.clear()
	
	for x in range(size):
		for y in range(size):
			if array[y][x]:
				$Content.set_cell(x, y, 0)

# Compute how many cells are occupied
func get_size():
	if !has_node("Content"):
		return 0
		
	return $Content.get_used_cells().size()