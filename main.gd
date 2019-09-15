extends Control

func _on_play():
	$Introduction.visible = false
	$Game.visible = true
	
func _on_game_over():
	$Introduction.visible = true
	$Game.visible = false
