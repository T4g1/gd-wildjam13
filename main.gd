extends Control

var highest = 0

func _on_play():
	$Introduction.visible = false
	$Game.visible = true

func _on_game_over(score):
	if score > highest:
		highest = score
		$Introduction.set_highest(score)
	
	$Introduction.visible = true
	$Game.visible = false