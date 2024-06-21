extends Area2D

onready var plus_sign := $PlusSign
var mouse_in := false

signal add_to_equation(value)

func _on_addition_mouse_entered():
	if GrabSprite.is_holding_character():
		plus_sign.show()

func _on_addition_mouse_exited():
	plus_sign.hide()

func _on_addition_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and !event.is_pressed() and GrabSprite.is_holding_character():
			emit_signal("add_to_equation",GrabSprite.character_holding)
