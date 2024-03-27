extends Node2D

const exponent_position_y := -24
const starting_position_y := 0
const gap_increment := 44

var starting_position_x := 0

const token_patterns = [
			['\\d+(\\.\\d+)?', 'NUMBER'],          # Match numbers [integer or floating-point]
			['x', 'VARIABLE'],  # Match variables [letters followed by letters, digits, or underscores]
			['[-\\+\\/]|(\\*){1,2}', 'OPERATOR'],            # Match operators [+, -, *, /]
			['[()]', 'PARENTHESIS'],           # Match parentheses
			['sin|cos|tan|csc|sec|cot', 'TRIG_FUNCTION'],                # Match trigonometric functions
		]

const character_sprite_preload := preload("res://characters.tscn")

func render_all(equation : String, answer : String):
	var equation_token = tokenize(equation)
	var answer_token = tokenize(answer)
	render_tokens(equation_token)
	create_character_sprite("=",Vector2(starting_position_x,starting_position_y))
	starting_position_x += gap_increment
	render_tokens(answer_token)

func create_character_sprite(character : String, char_position : Vector2):
	var obj = character_sprite_preload.instance()
	obj.characters = character
	obj.position = char_position
	call_deferred("add_child",obj)

func tokenize(expression : String):
	var regex = RegEx.new()
	var result = []
	regex.compile('(\\d+(\\.\\d+)?)|x|([-\\+\\/]|(\\*){1,2})|([()])|sin|cos|tan|csc|sec|cot')
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
					frac.append(index-1)
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

func render_tokens(tokens : Array):
	var index = 0
	var token_size = tokens.size()
	while index < token_size:
		var token : String = tokens[index]
		if token == "**":
			index += 1
			token = tokens[index]
			create_character_sprite(token,Vector2(starting_position_x,exponent_position_y))
			starting_position_x += gap_increment
		elif token == "sin" or token == "cos" or token == "tan" or token == "csc" or token == "sec" or token == "cot":
			create_character_sprite(token,Vector2(starting_position_x,starting_position_y))
			starting_position_x += 80
		elif token != "*":
			create_character_sprite(token,Vector2(starting_position_x,starting_position_y))
			starting_position_x += gap_increment*len(token)
		index += 1
	return starting_position_x

func change_to_wrong(tokens : Array):
	var new_tokens = tokens
	var modified_tokens = {}
	for i in range(tokens.size()):
		var token = tokens[i]
		if token != "**" and token != "*" and token != "x":
			modified_tokens[i] = tokens[i]
	var dict_size = modified_tokens.size()
	var dict_key = modified_tokens.keys()[randi() % dict_size]
	var dict_value = modified_tokens[dict_key]
	if dict_value == "+":
		new_tokens[dict_key] = "-"
	elif dict_value == "-":
		new_tokens[dict_key] = "+"
	else:
		new_tokens[dict_key] = randi() % 9 + 1
	return new_tokens
