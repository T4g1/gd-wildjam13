extends KinematicBody2D

signal clicked
signal double_click

var held = false

var original_position = Vector2()
var grabbed_offset = Vector2()

func _ready():
	original_position = get_position()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.doubleclick:
			emit_signal("double_click")
		elif event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked")

func _physics_process(_delta):
	if held:
		set_position(get_global_mouse_position() + grabbed_offset)

func pickup():
	held = true
	grabbed_offset = get_position() - get_global_mouse_position()

func drop():
	set_position(original_position)
	get_parent().modulate = Color(1.0, 1.0, 1.0, 1.0)
	held = false

func set_position(new_position):
	get_parent().position = new_position

func get_position():
	return get_parent().position