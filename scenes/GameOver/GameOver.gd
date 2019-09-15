extends AcceptDialog

onready var scoreLabel: Label = $VBoxContainer/Score
onready var highestLabel: Label = $VBoxContainer/Highest

func _ready():
	get_ok().text = "I love this game"

func display(score, is_highest):
	scoreLabel.text = str(score)
	
	visible = true
	highestLabel.visible = is_highest