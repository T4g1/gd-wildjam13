extends Control

signal game_over

func _on_game_over():
	emit_signal("game_over")