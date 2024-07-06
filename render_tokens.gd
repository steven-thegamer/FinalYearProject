extends Node2D

const gap_increment := 44

# ONLY FOR DISPLAY, DOES NOT HAVE ANY MEANING
const token_patterns = [
			['\\d+(\\.\\d+)?', 'NUMBER'],          # Match numbers [integer or floating-point]
			['x', 'VARIABLE'],  # Match variables [letters followed by letters, digits, or underscores]
			['[-\\+\\/]|(\\*){1,2}', 'OPERATOR'],            # Match operators [+, -, *, /]
			['[()]', 'PARENTHESIS'],           # Match parentheses
			['sin|cos|tan|csc|sec|cot', 'TRIG_FUNCTION'],                # Match trigonometric functions
			['log|e','LOG_FUNCTION']
		]

const character_sprite_preload := preload("res://characters.tscn")
const fraction_object := preload("res://fraction.tscn")
const addition_object := preload("res://addition_to_equation.tscn")

var first_time_generating := true

signal first_generate_equation

func render_all(equation : String):
	var equation_token = tokenize(equation)
	var better_equation_token = parse_tokens(equation_token)
	yield(render_tokens(better_equation_token,16,0),"completed")
	shrink_scale()

func create_character_sprite(character : String, char_position : Vector2, char_index : int):
	yield(get_tree(), "idle_frame")
	var obj = character_sprite_preload.instance()
	obj.original_question_parent = get_parent()
	obj.characters = character
	obj.position = char_position
	obj.char_pos_in_string = char_index
	call_deferred("add_child",obj)
	yield(obj,"ready")
	if first_time_generating:
		obj.appear_anim()

func tokenize(expression : String):
	var regex = RegEx.new()
	var result = []
	regex.compile('(\\d+(\\.\\d+)?)|x|([-\\+\\/]|(\\*){1,2})|([()])|sin|cos|tan|csc|sec|cot|log|exp')
	var arr_found = regex.search_all(expression)
	for discover in arr_found:
		result.append(discover.get_string())
	return result

func parse_tokens(tokens : Array):
	var index = 0
	var new_token_arr = []
	var fraction_indicator = []
	while index < len(tokens):
		if tokens[index] == "/":
			var frac = []
			# WHAT'S INSIDE THE FRAC? AN ARRAY OF THREE ELEMENTS
			# [NUM_INDEX, DENUM_INDEX, FRACTION]
			var numerator = ""
			var denominator = ""
			# STOP CHECKING IF () HITS OR AN OPERATOR +-
			# FIND THE NUMERATOR
			var parenthesis = 0
			for i in range(index-1, -1, -1):
				if tokens[i] == "(":
					parenthesis -= 1
				elif tokens[i] == ")":
					parenthesis += 1
				if ((tokens[i] == "+" or tokens[i] == "-") and parenthesis == 0):
					frac.append(i+1)
					break
				elif i == 0:
					numerator = tokens[i] + numerator
					frac.append(0)
					break
				else:
					numerator = tokens[i] + numerator
			# NOW FIND THE DENOMINATOR
			parenthesis = 0
			for i in range(index+1,len(tokens)):
				if tokens[i] == "(":
					parenthesis += 1
				elif tokens[i] == ")":
					parenthesis -= 1
				if (tokens[i] == "+" or tokens[i] == "-") and parenthesis == 0:
					index = i-1
					frac.append(i-1)
					break
				elif i == len(tokens) - 1:
					denominator += tokens[i]
					frac.append(i)
					break
				else:
					denominator += tokens[i]
			var new_token = numerator + "/" + denominator
			frac.append(new_token)
			fraction_indicator.append(frac)
		elif tokens[index] == "exp":
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

func render_tokens(tokens : Array, render_position_x : int, render_position_y : int):
	yield(get_tree(), "idle_frame")
	var index = 0
	var char_index = 0
	var token_size = tokens.size()
	var starting_position_x = render_position_x
	var starting_position_y = render_position_y
	var exponent_position_y = render_position_y - 24
	while index < token_size:
		var token_string : String = tokens[index]
		if token_string == "**":
			if index >= 1 and tokens[index - 1] != "e":
				char_index += 2
			index += 1
			var parenthesis = 0
			while index < token_size:
				if tokens[index] == "(":
					yield(create_character_sprite("(",Vector2(starting_position_x,exponent_position_y),char_index),"completed")
					starting_position_x += gap_increment
					parenthesis += 1
					char_index += 1
				elif tokens[index] == ")":
					yield(create_character_sprite(")",Vector2(starting_position_x,exponent_position_y),char_index),"completed")
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
							yield(create_character_sprite(power_token,Vector2(starting_position_x,exponent_position_y),char_index),"completed")
							starting_position_x += 80
							char_index += 3
						elif power_token != "*":
							yield(create_character_sprite(power_token,Vector2(starting_position_x,exponent_position_y),char_index),"completed")
							starting_position_x += gap_increment*len(power_token)
							char_index += len(power_token)
							if parenthesis == 0:
								break
						elif power_token == "*":
							char_index += 1
				index += 1
		elif "/" in token_string:
			var fraction_splitter = token_string.split("/")
			var numerator = fraction_splitter[0]
			var denumerator = fraction_splitter[1]
			var ori_x = starting_position_x
			var obj = fraction_object.instance()
			obj.numerator = numerator
			obj.denumerator = denumerator
			obj.position = Vector2(starting_position_x,starting_position_y)
			call_deferred("add_child",obj)
			yield(obj,"ready")
			starting_position_x += obj.longest_length + gap_increment
		elif token_string == "sin" or token_string == "cos" or token_string == "tan" or token_string == "csc" or token_string == "sec" or token_string == "cot":
			starting_position_x += 8
			yield(create_character_sprite(token_string,Vector2(starting_position_x,starting_position_y),char_index),"completed")
			starting_position_x += 96
			char_index += 3
		elif token_string == "ln":
			yield(create_character_sprite("ln",Vector2(starting_position_x,starting_position_y),char_index),"completed")
			starting_position_x += 80
			char_index += 3
		elif token_string == "e":
			yield(create_character_sprite("e",Vector2(starting_position_x,starting_position_y),char_index),"completed")
			starting_position_x += 40
			char_index += 3
		elif token_string != "*":
			yield(create_character_sprite(token_string,Vector2(starting_position_x,starting_position_y),char_index),"completed")
			starting_position_x += gap_increment*len(token_string)
			char_index += len(token_string)
		elif token_string == "*":
			char_index += 1
		index += 1
	emit_signal("first_generate_equation")

	var obj = addition_object.instance()
	obj.position = Vector2(starting_position_x + gap_increment * 1.5 ,starting_position_y)
	call_deferred("add_child",obj)
	obj.connect("add_to_equation",get_parent(),"add_value_at_end")

func display_all_token():
	for child in get_children():
		child.show()

func delete_all_token():
	for child in get_children():
		child.queue_free()

func shrink_scale() -> void:
	var amount_of_characters = get_child_count()
	if amount_of_characters > 15:
		var value = pow(0.95,amount_of_characters - 15)
		scale = Vector2(value,value)
	else:
		scale = Vector2(1,1)
