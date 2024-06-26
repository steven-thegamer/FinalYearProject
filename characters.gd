extends Area2D
class_name token

onready var collider = $CollisionShape2D
onready var char_sprite_node = $character_sprites
onready var anim = $AnimationPlayer

var characters : String
var char_pos_in_string : int
var original_question_parent
enum character_type {NUMBER, OPERATOR, VARIABLE, TRIG_FUNCTION, LOG_FUNCTION, PARENTHESIS}
var type : int
var clickable : bool = true
var draggable : bool = true

const character_sprite = preload("res://sprite_character.tscn")

func _ready():
	var shape = RectangleShape2D.new()
	shape.extents.x = 20 * characters.length() - 4
	shape.extents.y = 32
	var i = 0
	var index = 0
	if characters == "sin" or characters == "cos" or characters == "tan" or characters == "sec" or characters == "csc" or characters == "cot":
		shape.extents.x = 16 * characters.length() - 4
		var obj = character_sprite.instance()
		obj.character = characters
		obj.position.x = 32
		type = character_type.TRIG_FUNCTION
		char_sprite_node.add_child(obj)
		obj.material = obj.material.duplicate()
		set_collider_position_as_obj(obj)
	elif characters == "ln":
		shape.extents.x = 16 * characters.length() - 4
		var obj = character_sprite.instance()
		obj.character = characters
		obj.position.x = 32
		type = character_type.LOG_FUNCTION
		char_sprite_node.add_child(obj)
		obj.material = obj.material.duplicate()
		set_collider_position_as_obj(obj)
	else:
		if characters == "e":
			type = character_type.LOG_FUNCTION
		elif characters == "x":
			type = character_type.VARIABLE
		elif characters == "+" or characters == "-":
			clickable = false
			type = character_type.OPERATOR
		elif characters == "(" or characters == ")":
			type = character_type.PARENTHESIS
		else:
			type = character_type.NUMBER
		while i < characters.length():
			if characters[i] == "*":
				if i+1 < characters.length() and characters[i+1] == "*":
					i += 2
					var obj = character_sprite.instance()
					obj.character = characters[i]
					obj.position = Vector2(16+40*index,-32)
					char_sprite_node.add_child(obj)
					obj.material = obj.material.duplicate()
					index += 1
					set_collider_position_as_obj(obj)
			else:
				var obj = character_sprite.instance()
				obj.character = characters[i]
				obj.position.x = 16+40*index
				char_sprite_node.add_child(obj)
				obj.material = obj.material.duplicate()
				set_collider_position_as_obj(obj)
				index += 1
			i += 1
	collider.shape = shape

func set_collider_position_as_obj(obj : Node2D):
	collider.position = obj.position
	if characters == "sin" or characters == "cos" or characters == "tan" or characters == "sec" or characters == "csc" or characters == "cot" or characters == "ln":
		pass
	else:
		collider.position.x -= 20 * (characters.length() - 1)

func _on_characters_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.is_pressed() and draggable:
				GrabSprite.clone_children(char_sprite_node.get_children())
			elif not event.is_pressed() and GrabSprite.is_holding_character():
				match GrabSprite.type:
					GrabSprite.character_type.NUMBER:
						match type:
							character_type.LOG_FUNCTION:
								original_question_parent.update_equation_string_logarithm(characters, char_pos_in_string,GrabSprite.character_holding)
							character_type.NUMBER:
								original_question_parent.multiply_number_equation_string(characters,char_pos_in_string,GrabSprite.character_holding)
							character_type.OPERATOR:
								pass
							character_type.TRIG_FUNCTION:
								original_question_parent.multiply_trigonometry_on_equation_string(char_pos_in_string,GrabSprite.character_holding)
							character_type.VARIABLE:
								original_question_parent.update_equation_string_on_x_multiply(char_pos_in_string,GrabSprite.character_holding)
					GrabSprite.character_type.OPERATOR:
						if type != character_type.VARIABLE:
							original_question_parent.equation_string_switch_operator(characters,char_pos_in_string,GrabSprite.character_holding)
					GrabSprite.character_type.VARIABLE:
						original_question_parent.multiply_trigonometry_on_equation_string(char_pos_in_string,GrabSprite.character_holding)
					GrabSprite.character_type.TRIG_FUNCTION:
						if type == character_type.TRIG_FUNCTION:
							original_question_parent.multiply_trigonometry_equation_string(char_pos_in_string,GrabSprite.character_holding)
					GrabSprite.character_type.EQUATION:
						if original_question_parent.get_parent().name != "u-sub":
							original_question_parent.multiply_value_with_equation(GrabSprite.character_holding,char_pos_in_string,characters)
		
		# EVENTS OF RIGHT CLICKING
		elif event.button_index == 2:
			if event.is_pressed() and clickable:
				match type:
					character_type.VARIABLE:
						# SUBTRACT X POWER BY ONE
						original_question_parent.update_equation_string_on_x(char_pos_in_string)
					character_type.LOG_FUNCTION:
						if characters == "ln":
							# CONVERT FROM LN TO FRACTION
							original_question_parent.convert_ln_to_fraction(char_pos_in_string)
					character_type.TRIG_FUNCTION:
						# SWITCH TRIGONOMETRY FUNCTION
						original_question_parent.switch_trigonometry_on_equation_string(char_pos_in_string,characters)
					character_type.NUMBER:
						# SUBTRACT NUMBER BY ONE
						original_question_parent.subtract_number_equation_string(characters,char_pos_in_string)

func shake_anim():
	anim.play("shake")

func _on_characters_mouse_entered():
	for child in char_sprite_node.get_children():
		child.material.set_shader_param("active", true)


func _on_characters_mouse_exited():
	for child in char_sprite_node.get_children():
		child.material.set_shader_param("active", false)
