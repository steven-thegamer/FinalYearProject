class_name EquationParser
extends Reference

class Token:
	var type : String # op, num, var
	var value
	func _init(new_type: String, new_val):
		type = new_type
		value = new_val

static func parse(eq: String):
	var tokens = []
	var window = "" # Longest string
	
	var last_valid_window = ""
	var last_valid_type = ""
	
	var number_regex = RegEx.new()
	number_regex.compile("^\\d+$")
	
	var variable_regex = RegEx.new()
	variable_regex.compile("^\\w$")
	
	var op_regex = RegEx.new()
	op_regex.compile("^(\\*\\*|[+-/*])$")
	
	var current_chara = 0
	while current_chara < eq.length():
		# Append and check
		var c = eq[current_chara]
		window += c
		# Advance to the next character
		current_chara += 1
		
		if not number_regex.search(window) == null:
			last_valid_window = window
			last_valid_type = "num"
			continue
		
		if not variable_regex.search(window) == null:
			last_valid_window = window
			last_valid_type = "var"
			continue
			
		if not op_regex.search(window) == null:
			last_valid_window = window
			last_valid_type = "op"
			continue;
			
		# If all test case failed, and the last window is valid token
		tokens.append(Token.new(last_valid_type, last_valid_window))
		last_valid_type = ""
		last_valid_window = ""
		# However, because we did not validate c on its own, we do not want
		# want to move the pointer
		current_chara -= 1
		window = ""
	
	if window.length() > 0:
		if not number_regex.search(window) == null:
			tokens.append(Token.new("num", window))
		elif not op_regex.search(window) == null:
			tokens.append(Token.new("op", window))
		elif not variable_regex.search(window) == null:
			tokens.append(Token.new("var", window))

	return tokens

# Helps locate the token in string position
static func locate_token(tokens, pos: int):
	var s = ""
	for i in tokens.size():
		var token = tokens[i]
		s += token.value
		if s.length() > pos:
			return i
	return -1

static func token_to_string(tokens):
	var s = ""
	for token in tokens:
		s += token.value
	return s
