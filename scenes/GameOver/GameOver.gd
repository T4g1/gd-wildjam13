extends Popup

signal close

func _on_close():
	emit_signal("close")