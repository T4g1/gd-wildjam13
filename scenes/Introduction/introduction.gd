extends Control

signal play

func _on_play():
	print("play signal")
	emit_signal("play")