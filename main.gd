extends Control

func _on_play():
	print("play")
	$Introduction.visible = false
	$Game.visible = true
	
func _on_game_over():
	print("game over")
	$Introduction.visible = true
	$Game.visible = false
