tool
extends Node2D

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
	 [1, 0, 0, 0]]
]

enum PolyminoShape { Z = 0, S, L, J, O, I }
export(PolyminoShape) var shape = PolyminoShape.Z setget set_shape

func set_shape(new_shape):
	shape = new_shape
	
	$Grid.set_content(PATTERN[shape], TETROMINO_SIZE)