extends Area2D
class_name add_equation

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
			if GrabSprite.type == GrabSprite.character_type.NUMBER or GrabSprite.type == GrabSprite.character_type.VARIABLE or GrabSprite.type == GrabSprite.character_type.EQUATION:
				emit_signal("add_to_equation",GrabSprite.character_holding)
