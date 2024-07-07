extends Node2D

enum character_type {NUMBER, OPERATOR, VARIABLE, TRIG_FUNCTION, LOG_FUNCTION, PARENTHESIS, EQUATION}
var type : int
var character_holding : String

signal equation_effect(effect)

func _process(delta):
	global_position = get_global_mouse_position() + Vector2(-16,0)
	
	if Input.is_action_just_released("mouse_click"):
		if get_child_count() > 0:
			set_empty()

func clone_children(children : Array):
	for child in children:
		add_child(child.duplicate())
		character_holding += child.character
		
	if character_holding == "e" or character_holding == "ln":
		type = character_type.LOG_FUNCTION
	elif character_holding == "x":
		type = character_type.VARIABLE
	elif character_holding == "+" or character_holding == "-":
		type = character_type.OPERATOR
	elif character_holding == "sin" or character_holding == "cos" or character_holding == "tan" or character_holding == "sec" or character_holding == "csc" or character_holding == "cot":
		type = character_type.TRIG_FUNCTION
	elif character_holding == "(" or character_holding == ")":
		type = character_type.PARENTHESIS
	else:
		type = character_type.NUMBER

func clone_equation(children : Array, equation_value : String):
	character_holding = "(" + equation_value + ")"
	var prev_pos = INF
	var index = 0
	for i in range(children.size()-1):
		var child = children[i]
		var characters_node = child.char_sprite_node
		for character in characters_node.get_children():
			var obj = character.duplicate()
			add_child(obj)
			if prev_pos != INF:
				obj.position.x = character.global_position.x - prev_pos + index * 40 - 30
			prev_pos = character.global_position.x
			index += 1
	type = character_type.EQUATION

func set_empty():
	for child in get_children():
		child.queue_free()
	character_holding = ""

func is_holding_character() -> bool:
	return not character_holding.empty()
