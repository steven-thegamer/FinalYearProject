extends Panel

func _on_Panel_gui_input(event):
	if event is InputEventScreenDrag:
		rect_position += event.relative
