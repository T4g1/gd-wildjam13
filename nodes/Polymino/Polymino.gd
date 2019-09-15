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

func set_shape(new_shape):
	if !has_node("Grid"):
		return
	
	shape = new_shape
	
	$Grid.set_content(PATTERN[shape], TETROMINO_SIZE)

func _on_clicked():
	emit_signal("clicked", self)