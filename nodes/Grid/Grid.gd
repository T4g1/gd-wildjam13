tool
extends Node2D

export (int, 4, 100) var size = 15 setget set_size, get_size

func set_size(new_size):
	size = new_size
	
	$Lines.clear()
	$Content.clear()

	for x in range(size):
		for y in range(size):
			$Lines.set_cell(x, y, 0)

func get_size():
	return size