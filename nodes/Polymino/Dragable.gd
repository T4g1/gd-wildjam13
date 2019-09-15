extends KinematicBody2D

signal clicked

var held = false

var original_position = Vector2()
var grabbed_offset = Vector2()

func _ready():
	original_position = get_position()

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)

func _physics_process(delta):
	if held:
		set_position(get_global_mouse_position() + grabbed_offset)

func pickup():
	held = true
	grabbed_offset = get_position() - get_global_mouse_position()
	print("picked")

func drop():
	set_position(original_position)
	held = false
	print("dropped")

func set_position(new_position):
	get_parent().position = new_position

func get_position():
	return get_parent().position