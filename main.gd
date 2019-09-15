extends Control

var highest = 0

func _on_play():
	$Introduction.visible = false
	$Game.visible = true
	
	$Game.start_game()

func _on_game_over(score):
	var is_highest = score > highest
	if is_highest:
		highest = score
		$Introduction.set_highest(score)
	
	$GameOver.display(score, is_highest)

func _on_popup_hide():
	$Introduction.visible = true
	$Game.visible = false
