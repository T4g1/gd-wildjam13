extends Control

signal game_over

var score = 0

func _on_game_over():
	emit_signal("game_over", score)

func _process(_delta):
	if visible:
		_on_game_over()