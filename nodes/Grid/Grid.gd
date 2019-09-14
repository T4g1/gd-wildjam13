tool
extends Node2D

export (int, 4, 100) var size = 15 setget set_size
export (bool) var show_grid = true setget set_visibility

func set_size(new_size):
	size = new_size
	
	$Lines.clear()
	$Content.clear()

	for x in range(size):
		for y in range(size):
			$Lines.set_cell(x, y, 0)

func set_visibility(new_value):
	show_grid = new_value
	
	$Lines.visible = show_grid