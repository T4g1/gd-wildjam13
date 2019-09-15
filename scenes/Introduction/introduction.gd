extends Control

signal play

func _on_play():
	emit_signal("play")