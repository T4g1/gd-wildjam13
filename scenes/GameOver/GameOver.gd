extends AcceptDialog

onready var reasonLabel: Label = $VBoxContainer/Reason
onready var scoreLabel: Label = $VBoxContainer/Score
onready var highestLabel: Label = $VBoxContainer/Highest

func _ready():
	get_ok().text = "I love this game"

func display(reason, score, is_highest):
	reasonLabel.text = reason
	scoreLabel.text = str(score)
	
	visible = true
	highestLabel.visible = is_highest