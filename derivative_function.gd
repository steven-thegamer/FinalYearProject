extends Node2D

onready var render_token = $render_token

var original_equation_string := ""
var equation_string := ""
var all_targets := []
export var level_number := 1

const possible_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, - 1, - 2, - 3, - 4, - 5, - 6, - 7, - 8, - 9]
const possible_numbers_with_zero = [1, 2, 3, 4, 5, 6, 7, 8, 9, - 1, - 2, - 3, - 4, - 5, - 6, - 7, - 8, - 9, 0]

func _ready():
	randomize()
	generate_new_equation()
	render_token.connect("first_generate_equation",self,"_on_render_token_first_generate_equation")

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
	render_token.delete_all_token()
	# Render new tokens
	render_token.render_all(equation_string)

func revert_to_original():
	equation_string = original_equation_string
	render_token.delete_all_token()
	render_token.render_all(equation_string)

func number_multiply_number(number_dropped : String, position_multiply: int, number_dragged : String):
	equation_string = equation_string.replace(" ", "")
	var number_dropped_size = number_dropped.length()
	var back = equation_string.left(position_multiply)
	var front = equation_string.right(position_multiply + number_dropped_size)
	var new_value = str(int(number_dragged) * int(number_dropped))
	equation_string = back + new_value + front
	render_token.delete_all_token()
	render_token.render_all(equation_string)

func number_multiply_variable(x_position: int, number_dragged: String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(x_position)
	var front = equation_string.right(x_position+1)
	# THIS INDICATES THERE EXISTS A COEFFICIENT BEHIND X
	if !back.empty() and back[-1] == "*":
		var coefficient = ""
		var index = x_position - 2
		while index >= 0:
			if back[index] == "+" or back[index] == "-":
				break
			else:
				coefficient = back[index] + coefficient
			index -= 1
		number_multiply_number(coefficient,index + 1,number_dragged)
	# THIS MEANS THE COEFFICIENT IS JUST 1, WHICH IS NOT DISPLAYED
	else:
		back += number_dragged + "*"
		equation_string = back + "x" + front
		render_token.delete_all_token()
		render_token.render_all(equation_string)

func number_multiply_parenthesis(parenthesis_dropped : String,position_multiply:int, number_dragged : String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(position_multiply)
	var front = equation_string.right(position_multiply)
	if parenthesis_dropped == "(":
		if not back.empty() and back[-1] == "*":
			var coefficient = ""
			var index = position_multiply - 2
			while index >= 0:
				if back[index] == "+" or back[index] == "-":
					break
				elif back[index] == ")":
					break
				else:
					coefficient = back[index] + coefficient
				index -= 1
			if coefficient.find('x') != -1:
				number_multiply_variable(index + 1,number_dragged)
				return
			else:
				number_multiply_number(coefficient,index + 1,number_dragged)
				return
		front = number_dragged + "*" + front
	equation_string = back + front
	render_token.delete_all_token()
	render_token.render_all(equation_string)

func operator_multiply_number(number_pos: int, operator: String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(number_pos)
	var front = equation_string.right(number_pos)
	if back.empty():
		if operator == "-":
			equation_string = back + operator + front
	elif operator == "-":
		if back[-1] == "+":
			back[-1] = "-"
		elif back[-1] == "-":
			back[-1] = "+"
			if back[0] == "+":
				back = ""
		elif back[-1] == '(':
			back = back + '-'
		equation_string = back + front
	render_token.delete_all_token()
	render_token.render_all(equation_string)

func operator_multiply_operator(operator_dropped : String, operator_pos : int, operator_dragged : String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(operator_pos)
	var front = equation_string.right(operator_pos)
	if operator_dragged == "-":
		if operator_dragged == operator_dropped:
			front[0] = "+" if !back.empty() and back[-1] != '(' else ""
		else:
			front[0] = "-"
	equation_string = back + front
	render_token.delete_all_token()
	render_token.render_all(equation_string)

func operator_multiply_variable(x_position: int, operator: String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(x_position)
	var front = equation_string.right(x_position)
	if back.empty():
		if operator == "-":
			equation_string = back + operator + front
	elif operator == "-":
		var index = back.length() - 1
		while index >= 0:
			if back[index] == '+':
				back[index] = '-'
				break
			elif back[index] == '-':
				back[index] = '+' if index != 0 else ''
				break
			elif back[index] == '(':
				back = back.substr(0,index + 1) + '-' + back.substr(index + 1)
				break
			index -= 1
		equation_string = back + front
	render_token.delete_all_token()
	render_token.render_all(equation_string)

func variable_multiply_number(number_dropped : String, position_multiply : int):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(position_multiply)
	var number_size = number_dropped.length()
	var front = equation_string.right(position_multiply + number_size)
	if front.empty():
		front = "*x"
		equation_string = back + number_dropped + front
		render_token.delete_all_token()
		render_token.render_all(equation_string)
	else:
		if front[0] == "*" and front[1] == "x":
			variable_multiply_variable(position_multiply + number_size + 1)
		elif back[-1] != '*' and back[-2] != '*':
			front = '*x' + front
			equation_string = back + (number_dropped if number_dropped != '1' else '') + front
			render_token.delete_all_token()
			render_token.render_all(equation_string)
			
func variable_multiply_variable(x_position: int):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(x_position)
	var front = equation_string.right(x_position + 1)
	# CHECK IF THE X HAS POWER VALUE
	# IF X HAS POWER VALUE
	if not front.empty():
		if front[0] == "*" and front[1] == "*":
			var index = 2
			var power_value = ""
			while index < front.length():
				if front[index] == "+" or front[index] == "-":
					break
				power_value += front[index]
				index += 1
			power_value = str(int(power_value) + 1)
			front = front.right(index)
			equation_string = back + "x**" + power_value + front
		else:
			front = "x**2" + front
			equation_string = back + front
	# X DOESN'T HAVE ANY POWER VALUE
	else:
		front = "x**2"
		equation_string = back + front
	render_token.delete_all_token()
	render_token.render_all(equation_string)

func subtract_number_by_one(number_subtract: String, position_subtract: int):
	equation_string = equation_string.replace(" ", "")
	var size = number_subtract.length()
	var back = equation_string.left(position_subtract)
	var front = equation_string.right(position_subtract + size)
	var new_value = str(int(number_subtract) - 1)
	if new_value == "0":
		if not back.empty():
			if back[-1] == "+" or back[-1] == '-':
				back[-1] = ''
			elif back[-1] == '(':
				pass
			else:
				back += new_value
		# 0 +
		else:
			if front[0] == '+':
				front[0] = ''
		equation_string = back + front
	elif new_value == "1":
		# 0 : power
		# 1 : constant
		# 2 : coeff
		var value_type := 0
		if back.length() > 2 and back[-1] == "*" and back[-2] == "*":
			value_type = 0
		elif front.length() > 1 and front[0] == "*":
			value_type = 2
		else:
			value_type = 1
		
		match value_type:
			0:
				back = back.left(back.length() - 2)
				equation_string = back + front
			1:
				equation_string = back + new_value + front
			2:
				front[0] = ''
				equation_string = back + front
	else:
		equation_string = back + new_value + front
	
	render_token.delete_all_token()
	render_token.render_all(equation_string)

func subtract_variable_by_one(x_position : int):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(x_position)
	var front = equation_string.right(x_position+1)
	
	var has_power_value := false
	var has_coefficient := false
	
	if front.length() > 2 and front[0] == "*" and front[1] == "*":
		has_power_value = true
	if back.length() > 1 and back[-1] == "*":
		has_coefficient = true
	
	# If x**n where n != 1
	if has_power_value:
		var index = 2
		var parenthesis_counter := 0
		var power_value := ""
		while index < front.length():
			if parenthesis_counter == 0 and (front[index] == "+" or front[index] == "-"):
				break
			elif front[index] == ")":
				parenthesis_counter -= 1
			elif front[index] == "(":
				parenthesis_counter += 1
			else:
				power_value += front[index]
			index += 1
		subtract_number_by_one(power_value,x_position + 3)
		return
	# If x**1
	else:
		# If a*x where x is any number
		if has_coefficient:
			back[-1] = ''
			equation_string = back + front
		# if x
		else:
			equation_string = back + '1' + front
		render_token.delete_all_token()
		render_token.render_all(equation_string)

func add_value_at_end(value: String):
	equation_string = equation_string.replace(" ", "")
	if equation_string.empty():
		equation_string = value
	elif value[0] == "-":
		equation_string = equation_string + value
	else:
		equation_string = equation_string + "+" + value
	render_token.delete_all_token()
	render_token.render_all(equation_string)

func equation_multiply_number(equation : String, number_pos : int, number_dropped : String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(number_pos)
	var number_size = number_dropped.length()
	var front = equation_string.right(number_pos + number_size)
	front = '*' + equation + front
	equation_string = back + number_dropped + front
	render_token.delete_all_token()
	render_token.render_all(equation_string)

func equation_multiply_variable(equation : String, x_pos : int):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(x_pos)
	var front = equation_string.right(x_pos + 1)
	if not front.empty() and front[0] == '*' and front[1] == '*':
		back = back + equation + '*x'
		equation_string = back + front
	else:
		front = '*' + equation + front
		equation_string = back + 'x' + front
	render_token.delete_all_token()
	render_token.render_all(equation_string)

func equation_multiply_parenthesis(equation:String, parenthesis_pos : int, parenthesis_type : String):
	equation_string = equation_string.replace(" ", "")
	if parenthesis_type == '(':
		var back = equation_string.left(parenthesis_pos)
		var front = equation_string.right(parenthesis_pos)
		equation_string = back + equation + '*' + front
	elif parenthesis_type == ')':
		var back = equation_string.left(parenthesis_pos + 1)
		var front = equation_string.right(parenthesis_pos + 1)
		equation_string = back + '*' + equation + front
	render_token.delete_all_token()
	render_token.render_all(equation_string)

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
	render_token.delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	render_token.render_all(equation_string)

func multiply_trigonometry_on_equation_string(trigonometry_position: int, multiply_value: String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(trigonometry_position)
	var front = equation_string.right(trigonometry_position)
	equation_string = back + multiply_value + "*" + front
	render_token.delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	render_token.render_all(equation_string)

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
	render_token.delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	render_token.render_all(equation_string)

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
	render_token.delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	render_token.render_all(equation_string)

func update_equation_string_logarithm(character: String, log_pos: int, value: String):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(log_pos)
	var front = equation_string.right(log_pos + 3)
	if character == "e":
		equation_string = back + value + "*exp" + front
	elif character == "ln":
		equation_string = back + value + "*log" + front
	render_token.delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	render_token.render_all(equation_string)
		
func convert_ln_to_fraction(log_pos: int):
	equation_string = equation_string.replace(" ", "")
	var back = equation_string.left(log_pos)
	var front = equation_string.right(log_pos + 3)
	equation_string = back + "1/" + front
	render_token.delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	render_token.render_all(equation_string)

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
	render_token.delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	render_token.render_all(equation_string)

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
		
		if not back.empty() and back[index] == "/":
			equation_string = back + "/(" + equation + ")" + front
		else:
			equation_string = back + "*(" + equation + ")" + front
	else:
		var back = equation_string.left(value_pos)
		var front = equation_string.right(value_pos)
		
		if not back.empty() and back[-1] == "/":
			equation_string = back + "(" + equation + ")/" + front
		else:
			equation_string = back + "(" + equation + ")*" + front
	render_token.delete_all_token()
	equation_string = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	render_token.render_all(equation_string)

func evaluate_answer():
	var answer = EquationFixerAnswerGenerator.sympify_equation(equation_string)
	return all_targets.has(answer)

func make_all_equation_shake():
	for child in render_token.get_children():
		if child.has_method("shake_anim"):
			child.shake_anim()

func reactivate_first_time_generating():
	render_token.first_time_generating = true

func _on_render_token_first_generate_equation():
	render_token.first_time_generating = false
