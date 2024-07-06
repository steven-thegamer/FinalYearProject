extends Area2D

var u_equation_string := ""
onready var render_token = $u
onready var bin = $bin

func _ready():
	connect("input_event",self,"input_get_equation")
	bin.connect("pressed",self,"reset_u")
	render_token.render_all("")

func multiply_trigonometry_equation_string(position_multiply: int, string_multiply: String):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(position_multiply)
	var parenthesis_counter = 0
	var inside_trig_function := ""
	var limit_front = 0
	for i in range(position_multiply + 3, u_equation_string.length()):
		if u_equation_string[i] == "(":
			parenthesis_counter += 1
		elif u_equation_string[i] == ")":
			parenthesis_counter -= 1
			if parenthesis_counter == 0:
				limit_front = i + 1
				break
		else:
			inside_trig_function += u_equation_string[i]
	inside_trig_function = "(" + inside_trig_function + ")"
	var full_trig_function = u_equation_string.substr(position_multiply, 3) + inside_trig_function
	var multiplier_trig = string_multiply + inside_trig_function
	var front = u_equation_string.right(limit_front)
	u_equation_string = back + multiplier_trig + "*" + full_trig_function + front
	render_token.delete_all_token()
	u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
	render_token.render_all(u_equation_string)

func multiply_number_equation_string(value: String, position_multiply: int, multiply_value: String):
	u_equation_string = u_equation_string.replace(" ", "")
	var size = value.length()
	var back = u_equation_string.left(position_multiply)
	var front = u_equation_string.right(position_multiply + size)
	var new_value = str(int(value) * int(multiply_value))
	u_equation_string = back + new_value + front
	render_token.delete_all_token()
	u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
	render_token.render_all(u_equation_string)

func subtract_number_equation_string(value: String, position_subtract: int):
	u_equation_string = u_equation_string.replace(" ", "")
	var size = value.length()
	# NOTE: for fk sake front is the left la not right
	var back = u_equation_string.left(position_subtract)
	var front = u_equation_string.right(position_subtract + size)
	var new_value = str(int(value) - 1)
	# Please check all comments with "EDGE CASE" and "NOTE"
	# EDGE CASE:
	# 1. 2x**3, since the "back" is [], accessing
	# back[-1] and back[-2] will result an error
	# 2. You can multiply - with -, hence -2x**2 (drag the minus
	# to itself) will create --2x**2 (same with x too apparently)
	# 3. in -2x**2, if you drag the minus to the power it will become
	# -2x-2 instead of -2x**(-2)
	#  4. If you have -3x**3, dragging the 3 to x will result in -33x**3
	# instead of -9x**3, but this could be a feature i suppose
	# 
	if new_value == "1":
		if not front.empty() and front[0] == "*":
			if front[1] == "*":
				# 1**x
				pass
			else:
				# 1*x
				new_value = ""
				front = front.right(1)
		if not back.empty() and back[- 1] == "*":
			if back[- 2] == "*":
				# **1
				new_value = ""
				back = back.left(back.length() - 2)
			else:
				# *1
				new_value = ""
				back = back.left(back.length() - 1)
				
	elif new_value == "0":
		if not front.empty() and front[0] == "*":
			if front[1] == "*":
				# 0**x
				pass
			elif front[1] == "x":
				# 0*x
				# NOTE: 0*x = 0, should not simplify to x
				# SEARCH FRONT UNTIL THERE EXISTS AN OPERATOR (+ OR -) OR A PARENTHESIS ()
				var index = 1
				while index < front.length():
					if front[index] == "+" or front[index] == "-" or front[index] == ")" or front[index] == "(":
						break
					index += 1
				front = front.right(index)
			else:
				# 0+
				# 0-
				new_value = ""
				front = front.right(1)
		if not back.empty() and back[- 1] == "*":
			if back[- 2] == "*":
				# **0
				new_value = ""
				back = back.left(back.length() - 2)
			else:
				# *0
				new_value = ""
				back = back.left(back.length() - 1)
		elif not back.empty() and (back[- 1] == "+" or back[- 1] == "-"):
			# +0 or -0
			new_value = ""
			back = back.left(back.length() - 1)
		elif not back.empty() and back[- 1] == "(":
			# (0
			new_value = ""
			
	# NOTE: William attempted hotfix
	# From my playtesting, in cases such as x**3, the position to substract is
	# no longer accurate unfortunately. If the user right click on the x instead
	# of 3, the position becomes 0 instead of the last element, hence the check
	# is basically invalid
	
	# NOTE: this technique is not good for handling double digit
	# Example, 33x**3, clicking on 33 will not handle it properly and just
	# substract from one instead of all
	u_equation_string = back + new_value + front
	
	render_token.delete_all_token()
	u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
	render_token.render_all(u_equation_string)

func multiply_trigonometry_on_equation_string(trigonometry_position: int, multiply_value: String):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(trigonometry_position)
	var front = u_equation_string.right(trigonometry_position)
	u_equation_string = back + multiply_value + "*" + front
	render_token.delete_all_token()
	u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
	render_token.render_all(u_equation_string)

func update_equation_string_on_trigonometry(trigonometry_position: int, power_value: String):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(trigonometry_position)
	var trigonomety_equation = ""
	var front_limit_position = 0
	var parenthesis_counter = 0
	for i in range(trigonometry_position, u_equation_string.length()):
		if u_equation_string[i] == "(":
			trigonomety_equation += u_equation_string[i]
			parenthesis_counter += 1
		elif u_equation_string[i] == ")":
			trigonomety_equation += u_equation_string[i]
			parenthesis_counter -= 1
			if parenthesis_counter == 0:
				front_limit_position = i + 1
				break
		else:
			trigonomety_equation += u_equation_string[i]
	var front = u_equation_string.right(front_limit_position)
	u_equation_string = back + "(" + trigonomety_equation + "**" + power_value + ")" + front
	render_token.delete_all_token()
	u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
	render_token.render_all(u_equation_string)

func switch_trigonometry_on_equation_string(trigonometry_position: int, trig_value: String):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(trigonometry_position)
	var front = u_equation_string.right(trigonometry_position + 3)
	# TO DO: GENERATE THE DERIVATIVES OF THE TRIGONOMETRY FUNCTIONS
	match trig_value:
		"sin":
			u_equation_string = back + "cos" + front
		"cos":
			u_equation_string = back + "-sin" + front
		"tan":
			u_equation_string = back + "sec" + front
		"sec":
			u_equation_string = back + "tan" + front
		"csc":
			u_equation_string = back + "-cot" + front
		"cot":
			u_equation_string = back + "-csc" + front
	render_token.delete_all_token()
	u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
	render_token.render_all(u_equation_string)

func update_equation_string_on_x(x_position: int):
	u_equation_string = u_equation_string.replace(" ", "")
	if x_position + 1 < u_equation_string.length() and u_equation_string[x_position + 1] == "*" and u_equation_string[x_position + 2] == "*":
		var power_x_value = u_equation_string[x_position + 3]
		var new_power_value = str(int(power_x_value) - 1)
		var back = u_equation_string.left(x_position + 3)
		var front = u_equation_string.right(x_position + 4)
		u_equation_string = back + new_power_value + front
	else:
		var back = u_equation_string.left(x_position)
		var front = u_equation_string.right(x_position + 1)
		u_equation_string = back + "1" + front
	render_token.delete_all_token()
	u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
	render_token.render_all(u_equation_string)

func update_equation_string_on_x_multiply(x_position: int, value: String):
	u_equation_string = u_equation_string.replace(" ", "")
	if x_position > 0 and u_equation_string[x_position - 1] == "*":
		var back = u_equation_string.left(x_position)
		var front = u_equation_string.right(x_position + 1)
		u_equation_string = back + value + "*x" + front
		render_token.delete_all_token()
		u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
		render_token.render_all(u_equation_string)
	else:
		var back = u_equation_string.left(x_position)
		var front = u_equation_string.right(x_position + 1)
		u_equation_string = back + value + "*x" + front
		render_token.delete_all_token()
		u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
		render_token.render_all(u_equation_string)

func update_equation_string_logarithm(character: String, log_pos: int, value: String):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(log_pos)
	var front = u_equation_string.right(log_pos + 3)
	if character == "e":
		u_equation_string = back + value + "*exp" + front
	elif character == "ln":
		u_equation_string = back + value + "*log" + front
	render_token.delete_all_token()
	u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
	render_token.render_all(u_equation_string)
		
func convert_ln_to_fraction(log_pos: int):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(log_pos)
	var front = u_equation_string.right(log_pos + 3)
	u_equation_string = back + "1/" + front
	render_token.delete_all_token()
	u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
	render_token.render_all(u_equation_string)

func equation_string_switch_operator(character: String, operator_pos: int, another_character: String):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(operator_pos)
	var size = character.length()
	var front = u_equation_string.right(operator_pos + size)
	var new_character := another_character
	if character == "-" or character == "+":
		if character == another_character:
			new_character = "+"
		else:
			new_character = "-"
	else:
		new_character = another_character + character
	u_equation_string = back + new_character + front
	render_token.delete_all_token()
	u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
	render_token.render_all(u_equation_string)

func multiply_value_with_equation(equation: String, value_pos: int, character_hovered_at: String):
	u_equation_string = u_equation_string.replace(" ", "")
	if character_hovered_at == ")":
		var back = u_equation_string.left(value_pos + 1)
		var front = u_equation_string.right(value_pos + 1)
		
		# SYMPY WORKS BY READING AN EQUATION FROM LEFT TO RIGHT
		var parenthesis_counter = 1
		var index = -2
		while parenthesis_counter > 0:
			if back[index] == ")":
				parenthesis_counter += 1
			elif back[index] == "(":
				parenthesis_counter -= 1
			index -= 1
		
		if back[index] == "/":
			u_equation_string = back + "/(" + equation + ")" + front
		else:
			u_equation_string = back + "*(" + equation + ")" + front
	else:
		var back = u_equation_string.left(value_pos)
		var front = u_equation_string.right(value_pos)
		
		if back[- 1] == "/":
			u_equation_string = back + "(" + equation + ")/" + front
		else:
			u_equation_string = back + "(" + equation + ")*" + front
	render_token.delete_all_token()
	u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
	render_token.render_all(u_equation_string)
	GrabSprite.emit_signal("equation_u_sub")

func add_value_at_end(value: String):
	u_equation_string = u_equation_string.replace(" ", "")
	u_equation_string = u_equation_string + "+" + value
	render_token.delete_all_token()
#	u_equation_string = EquationFixerAnswerGenerator.sympify_equation(u_equation_string)
	render_token.render_all(u_equation_string)

func input_get_equation(viewport, event, shape_idx):
	if event is InputEventMouseButton and !u_equation_string.empty() and event.button_index == 1 and event.is_pressed():
		GrabSprite.clone_equation(render_token.get_children(),u_equation_string)

func reset_u():
	u_equation_string = ""
	render_token.delete_all_token()
	render_token.render_all("")
