extends Node2D

var original_equation_string := ""
var equation_string := ""
var all_targets := []
export var level_number := 1

const possible_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, - 1, - 2, - 3, - 4, - 5, - 6, - 7, - 8, - 9]
const possible_numbers_with_zero = [1, 2, 3, 4, 5, 6, 7, 8, 9, - 1, - 2, - 3, - 4, - 5, - 6, - 7, - 8, - 9, 0]

func _ready():
	generate_new_equation()

# This is to create the string of the equation
func generate_equation(number=level_number):
	var level_equation: String
	if number == 1:
		level_equation = "a*x**n"
		level_equation = level_equation.replace("a", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("n", str(randi() % 4 + 2))
	elif number == 2:
		level_equation = "a*x**2 + b*x"
		level_equation = level_equation.replace("a", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("b", str(possible_numbers[randi() % possible_numbers.size()]))
	elif number == 3:
		var size = randi() % 3 + 2
		level_equation = "a*x**2 + b*x + c"
		if size == 3:
			level_equation = "a*x**3 + b*x**2 + c*x + d"
			level_equation = level_equation.replace("d", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
		elif size == 4:
			level_equation = "a*x**4 + b*x**3 + c*x**2 + d*x + e"
			level_equation = level_equation.replace("d", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
			level_equation = level_equation.replace("e", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("a", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("b", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
		level_equation = level_equation.replace("c", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
	elif number == 4:
		level_equation = "(a*x + b)*(c*x + d)"
		level_equation = level_equation.replace("a", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("b", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
		level_equation = level_equation.replace("c", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("d", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
	elif number == 5:
		var possible_choice = randi() % 2
		level_equation = "(a*x + b)*(c*x + d)"
		if possible_choice == 0:
			# GENERATE (ax+b)(cx+d)
			level_equation = level_equation.replace("a", str(possible_numbers[randi() % possible_numbers.size()]))
			level_equation = level_equation.replace("b", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
			level_equation = level_equation.replace("c", str(possible_numbers[randi() % possible_numbers.size()]))
			level_equation = level_equation.replace("d", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
		elif possible_choice == 1:
			# GENERATE (ax**2 + bx + c)(dx + e)
			level_equation = "(a*x**2 + b*x + c)*(d*x + e)"
			level_equation = level_equation.replace("a", str(possible_numbers[randi() % possible_numbers.size()]))
			level_equation = level_equation.replace("b", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
			level_equation = level_equation.replace("c", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
			level_equation = level_equation.replace("d", str(possible_numbers[randi() % possible_numbers.size()]))
			level_equation = level_equation.replace("e", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
	elif number == 6:
		level_equation = "(a*x + b)/(c*x + d)"
		level_equation = level_equation.replace("a", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("b", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("c", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("d", str(possible_numbers[randi() % possible_numbers.size()]))
	elif number == 7:
		var possible_choice = randi() % 3
		level_equation = "(a*x + b)/(c*x + d)"
		if possible_choice == 1:
			level_equation = "(a*x**2 + b*x + c)/(d*x + e)"
			level_equation = level_equation.replace("e", str(possible_numbers[randi() % possible_numbers.size()]))
		elif possible_choice == 2:
			level_equation = "(a*x + b)/(c*x**2 + d*x + e)"
			level_equation = level_equation.replace("e", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
		level_equation = level_equation.replace("a", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("b", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
		level_equation = level_equation.replace("c", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("d", str(possible_numbers[randi() % possible_numbers.size()]))
	elif number == 8:
		level_equation = "(a*x + b)**c"
		level_equation = level_equation.replace("a", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("b", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("c", str(randi() % 5 + 4))
	elif number == 9:
		var possible_choice = randi() % 3
		level_equation = "(a*x + b)**c"
		if possible_choice == 1:
			level_equation = "d*(a*x + b)**c"
			level_equation = level_equation.replace("d", str(possible_numbers[randi() % possible_numbers.size()]))
		elif possible_choice == 2:
			level_equation = "(a*x**2 + b*x + d)**c"
			level_equation = level_equation.replace("d", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
		level_equation = level_equation.replace("a", str(possible_numbers[randi() % possible_numbers.size()]))
		level_equation = level_equation.replace("b", str(possible_numbers_with_zero[randi() % possible_numbers_with_zero.size()]))
		level_equation = level_equation.replace("c", str(randi() % 5 + 4))
	return level_equation

# This is to generate the new equation
func generate_new_equation():
	#This generate an equation in a string form
	equation_string = generate_equation()
	# We convert the string form to be in a perfect grammar since we don't want this to happen
	# x + -3
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	# Set variable to equation to be able to reset
	original_equation_string = equation_string
	# Generate the derivative form
	all_targets = EquationFixerAnswerGenerator.all_derivative_answers(equation_string)
	# Delete all generated tokens if any
	get_node("render_token").delete_all_token()
	# Render new tokens
	get_node("render_token").render_all(equation_string)

func revert_to_original():
	equation_string = original_equation_string
	get_node("render_token").delete_all_token()
	get_node("render_token").render_all(equation_string)

func multiply_trigonometry_equation_string(position_multiply: int, string_multiply: String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(position_multiply)
	var parenthesis_counter = 0
	var inside_trig_function := ""
	var limit_front = 0
	for i in range(position_multiply + 3, equation_string.length()):
		if equation_string[i] == "(":
			parenthesis_counter += 1
		elif equation_string[i] == ")":
			parenthesis_counter -= 1
			if parenthesis_counter == 0:
				limit_front = i + 1
				break
		else:
			inside_trig_function += equation_string[i]
	inside_trig_function = "(" + inside_trig_function + ")"
	var full_trig_function = equation_string.substr(position_multiply, 3) + inside_trig_function
	var multiplier_trig = string_multiply + inside_trig_function
	var front = equation_string.right(limit_front)
	equation_string = back + multiplier_trig + "*" + full_trig_function + front
	get_node("render_token").delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func multiply_number_equation_string(value: String, position_multiply: int, multiply_value: String):
	equation_string = equation_string.replace(" ", "")
	var size = value.length()
	var back = equation_string.left(position_multiply)
	var front = equation_string.right(position_multiply + size)
	var new_value = str(int(value) * int(multiply_value))
	equation_string = back + new_value + front
	get_node("render_token").delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func subtract_number_equation_string(value: String, position_subtract: int):
	equation_string = equation_string.replace(" ", "")
	var size = value.length()
	# NOTE: for fk sake front is the left la not right
	var back = equation_string.left(position_subtract)
	var front = equation_string.right(position_subtract + size)
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
	equation_string = back + new_value + front
	
	get_node("render_token").delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func multiply_trigonometry_on_equation_string(trigonometry_position: int, multiply_value: String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(trigonometry_position)
	var front = equation_string.right(trigonometry_position)
	equation_string = back + multiply_value + "*" + front
	get_node("render_token").delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func update_equation_string_on_trigonometry(trigonometry_position: int, power_value: String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(trigonometry_position)
	var trigonomety_equation = ""
	var front_limit_position = 0
	var parenthesis_counter = 0
	for i in range(trigonometry_position, equation_string.length()):
		if equation_string[i] == "(":
			trigonomety_equation += equation_string[i]
			parenthesis_counter += 1
		elif equation_string[i] == ")":
			trigonomety_equation += equation_string[i]
			parenthesis_counter -= 1
			if parenthesis_counter == 0:
				front_limit_position = i + 1
				break
		else:
			trigonomety_equation += equation_string[i]
	var front = equation_string.right(front_limit_position)
	equation_string = back + "(" + trigonomety_equation + "**" + power_value + ")" + front
	get_node("render_token").delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func switch_trigonometry_on_equation_string(trigonometry_position: int, trig_value: String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(trigonometry_position)
	var front = equation_string.right(trigonometry_position + 3)
	# TO DO: GENERATE THE DERIVATIVES OF THE TRIGONOMETRY FUNCTIONS
	match trig_value:
		"sin":
			equation_string = back + "cos" + front
		"cos":
			equation_string = back + "-sin" + front
		"tan":
			equation_string = back + "sec" + front
		"sec":
			equation_string = back + "tan" + front
		"csc":
			equation_string = back + "-cot" + front
		"cot":
			equation_string = back + "-csc" + front
	get_node("render_token").delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func update_equation_string_on_x(x_position: int):
	equation_string = equation_string.replace(" ", "")
	if x_position + 1 < equation_string.length() and equation_string[x_position + 1] == "*" and equation_string[x_position + 2] == "*":
		var power_x_value = equation_string[x_position + 3]
		var new_power_value = str(int(power_x_value) - 1)
		var back = equation_string.left(x_position + 3)
		var front = equation_string.right(x_position + 4)
		equation_string = back + new_power_value + front
	else:
		var back = equation_string.left(x_position)
		var front = equation_string.right(x_position + 1)
		equation_string = back + "1" + front
	get_node("render_token").delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func update_equation_string_on_x_multiply(x_position: int, value: String):
	equation_string = equation_string.replace(" ", "")
	if x_position > 0 and equation_string[x_position - 1] == "*":
		var back = equation_string.left(x_position)
		var front = equation_string.right(x_position + 1)
		equation_string = back + value + "*x" + front
		get_node("render_token").delete_all_token()
		equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
		get_node("render_token").render_all(equation_string)
	else:
		var back = equation_string.left(x_position)
		var front = equation_string.right(x_position + 1)
		equation_string = back + value + "*x" + front
		get_node("render_token").delete_all_token()
		equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
		get_node("render_token").render_all(equation_string)

func update_equation_string_logarithm(character: String, log_pos: int, value: String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(log_pos)
	var front = equation_string.right(log_pos + 3)
	if character == "e":
		equation_string = back + value + "*exp" + front
	elif character == "ln":
		equation_string = back + value + "*log" + front
	get_node("render_token").delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)
		
func convert_ln_to_fraction(log_pos: int):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(log_pos)
	var front = equation_string.right(log_pos + 3)
	equation_string = back + "1/" + front
	get_node("render_token").delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func equation_string_switch_operator(character: String, operator_pos: int, another_character: String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(operator_pos)
	var size = character.length()
	var front = equation_string.right(operator_pos + size)
	var new_character := another_character
	if character == "-" or character == "+":
		if character == another_character:
			new_character = "+"
		else:
			new_character = "-"
	else:
		new_character = another_character + character
	equation_string = back + new_character + front
	get_node("render_token").delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func multiply_value_with_equation(equation: String, value_pos: int, character_hovered_at: String):
	equation_string = equation_string.replace(" ", "")
	if character_hovered_at == ")":
		var back = equation_string.left(value_pos + 1)
		var front = equation_string.right(value_pos + 1)
		
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
			equation_string = back + "/(" + equation + ")" + front
		else:
			equation_string = back + "*(" + equation + ")" + front
	else:
		var back = equation_string.left(value_pos)
		var front = equation_string.right(value_pos)
		
		if back[- 1] == "/":
			equation_string = back + "(" + equation + ")/" + front
		else:
			equation_string = back + "(" + equation + ")*" + front
	get_node("render_token").delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)
	GrabSprite.emit_signal("equation_u_sub")

func evaluate_answer():
	var answer = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	return all_targets.has(answer)

func make_all_equation_shake():
	for child in get_node("render_token").get_children():
		if child.has_method("shake_anim"):
			child.shake_anim()

func add_value_at_end(value: String):
	equation_string = equation_string.replace(" ", "")
	equation_string = equation_string + "+" + value
	get_node("render_token").delete_all_token()
#	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)
