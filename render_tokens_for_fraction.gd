extends Node2D

const gap_increment := 44

var starting_position_x := 16

const token_patterns = [
			['\\d+(\\.\\d+)?', 'NUMBER'],          # Match numbers [integer or floating-point]
			['x', 'VARIABLE'],  # Match variables [letters followed by letters, digits, or underscores]
			['[-\\+\\/]|(\\*){1,2}', 'OPERATOR'],            # Match operators [+, -, *, /]
			['[()]', 'PARENTHESIS'],           # Match parentheses
			['sin|cos|tan|csc|sec|cot', 'TRIG_FUNCTION'],                # Match trigonometric functions
			['log|e','LOG_FUNCTION']
		]

const character_sprite_preload := preload("res://characters.tscn")
const addition_object := preload("res://addition_to_equation.tscn")

func create_character_sprite(character : String, char_position : Vector2, char_index : int):
	var obj = character_sprite_preload.instance()
	obj.original_question_parent = owner.get_parent().get_parent()
	obj.characters = character
	obj.position = char_position
	obj.char_pos_in_string = char_index
	call_deferred("add_child",obj)
#	obj.hide()

func tokenize(expression : String):
	var regex = RegEx.new()
	var result = []
	regex.compile('(\\d+(\\.\\d+)?)|x|([-\\+]|(\\*){1,2})|([()])|sin|cos|tan|csc|sec|cot|log|exp')
	var arr_found = regex.search_all(expression)
	for discover in arr_found:
		result.append(discover.get_string())
	return result

func parse_tokens(tokens : Array):
	var index = 0
	var new_token_arr = []
	var fraction_indicator = []
	while index < len(tokens):
		if tokens[index] == "exp":
			tokens[index] = "e"
			tokens.insert(index+1,"**")
		elif tokens[index] == "log":
			tokens[index] = "ln"
		index += 1
	var index_2 = 0
	while index_2 < len(tokens):
		if fraction_indicator.size() > 0 and fraction_indicator[0][0] == index_2:
			new_token_arr.append(fraction_indicator[0][2])
			index_2 = fraction_indicator[0][1]
			fraction_indicator.pop_front()
		else:
			new_token_arr.append(tokens[index_2])
		index_2 += 1
	return new_token_arr

func render_tokens(tokens : Array, render_position_x : int, render_position_y : int, char_index_value : int):
	var index = 0
	var char_index = char_index_value
	var token_size = tokens.size()
	var starting_position_x = render_position_x
	var starting_position_y = render_position_y
	var exponent_position_y = render_position_y - 24
	while index < token_size:
		var token : String = tokens[index]
		if token == "**":
			if index > 1 and tokens[index - 1] != "e":
				char_index += 2
			index += 1
			var parenthesis = 0
			while index < token_size:
				if tokens[index] == "(":
					create_character_sprite("(",Vector2(starting_position_x,exponent_position_y),char_index)
					starting_position_x += gap_increment
					parenthesis += 1
					char_index += 1
				elif tokens[index] == ")":
					create_character_sprite(")",Vector2(starting_position_x,exponent_position_y),char_index)
					starting_position_x += gap_increment
					parenthesis -= 1
					char_index += 1
				else:
					var power_token = tokens[index]
					if (tokens[index] == "+" or tokens[index] == "-") and parenthesis == 0:
						index -= 1
						break
					else:
						if power_token == "sin" or power_token == "cos" or power_token == "tan" or power_token == "csc" or power_token == "sec" or power_token == "cot":
							create_character_sprite(power_token,Vector2(starting_position_x,exponent_position_y),char_index)
							starting_position_x += 80
							char_index += 3
						elif power_token != "*":
							create_character_sprite(power_token,Vector2(starting_position_x,exponent_position_y),char_index)
							starting_position_x += gap_increment*len(power_token)
							char_index += len(power_token)
							if parenthesis == 0:
								break
						elif power_token == "*":
							char_index += 1
				index += 1
		elif token == "sin" or token == "cos" or token == "tan" or token == "csc" or token == "sec" or token == "cot":
			starting_position_x += 8
			create_character_sprite(token,Vector2(starting_position_x,starting_position_y),char_index)
			starting_position_x += 96
			char_index += 3
		elif token == "ln":
			create_character_sprite("ln",Vector2(starting_position_x,starting_position_y),char_index)
			starting_position_x += 80
			char_index += 3
		elif token == "e":
			create_character_sprite("e",Vector2(starting_position_x,starting_position_y),char_index)
			starting_position_x += 40
			char_index += 3
		elif token != "*":
			create_character_sprite(token,Vector2(starting_position_x,starting_position_y),char_index)
			starting_position_x += gap_increment*len(token)
			char_index += len(token)
		elif token == "*":
			char_index += 1
		index += 1
	var obj = addition_object.instance()
	obj.position = Vector2(starting_position_x + gap_increment * 1.5 ,starting_position_y)
	call_deferred("add_child",obj)
	obj.connect("add_to_equation",get_parent().get_parent().get_parent(),"add_value_at_end")
	return Vector2(starting_position_x,char_index)

func display_all_token():
	for child in get_children():
		child.show()

func delete_all_token():
	for child in get_children():
		child.queue_free()
