extends Control

signal play

func _on_play():
	emit_signal("play")

func set_highest(score):
	find_node("HighestLabel").text = "Highest: " + str(score)