extends Area2D

var u_equation_string := ""
onready var render_token = $u
onready var bin = $bin

func _ready():
	connect("input_event",self,"input_get_equation")
	bin.connect("pressed",self,"reset_u")
	render_token.render_all("")


func number_multiply_number(number_dropped : String, position_multiply: int, number_dragged : String):
	u_equation_string = u_equation_string.replace(" ", "")
	var number_dropped_size = number_dropped.length()
	var back = u_equation_string.left(position_multiply)
	var front = u_equation_string.right(position_multiply + number_dropped_size)
	var new_value = str(int(number_dragged) * int(number_dropped))
	u_equation_string = back + new_value + front
	render_token.delete_all_token()
	render_token.render_all(u_equation_string)

func number_multiply_variable(x_position: int, number_dragged: String):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(x_position)
	var front = u_equation_string.right(x_position+1)
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
		u_equation_string = back + "x" + front
		render_token.delete_all_token()
		render_token.render_all(u_equation_string)

func number_multiply_parenthesis(parenthesis_dropped : String,position_multiply:int, number_dragged : String):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(position_multiply)
	var front = u_equation_string.right(position_multiply)
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
	u_equation_string = back + front
	render_token.delete_all_token()
	render_token.render_all(u_equation_string)

func operator_multiply_number(number_pos: int, operator: String):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(number_pos)
	var front = u_equation_string.right(number_pos)
	if back.empty():
		if operator == "-":
			u_equation_string = back + operator + front
	elif operator == "-":
		if back[-1] == "+":
			back[-1] = "-"
		elif back[-1] == "-":
			back[-1] = "+"
			if back[0] == "+":
				back = ""
		elif back[-1] == '(':
			back = back + '-'
		u_equation_string = back + front
	render_token.delete_all_token()
	render_token.render_all(u_equation_string)

func operator_multiply_operator(operator_dropped : String, operator_pos : int, operator_dragged : String):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(operator_pos)
	var front = u_equation_string.right(operator_pos)
	if operator_dragged == "-":
		if operator_dragged == operator_dropped:
			front[0] = "+" if !back.empty() else ""
		else:
			front[0] = "-"
	u_equation_string = back + front
	render_token.delete_all_token()
	render_token.render_all(u_equation_string)

func operator_multiply_variable(x_position: int, operator: String):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(x_position)
	var front = u_equation_string.right(x_position)
	if back.empty():
		if operator == "-":
			u_equation_string = back + operator + front
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
		u_equation_string = back + front
	render_token.delete_all_token()
	render_token.render_all(u_equation_string)

func variable_multiply_number(number_dropped : String, position_multiply : int):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(position_multiply)
	var number_size = number_dropped.length()
	var front = u_equation_string.right(position_multiply + number_size)
	if front.empty():
		front = "*x"
		u_equation_string = back + number_dropped + front
		render_token.delete_all_token()
		render_token.render_all(u_equation_string)
	else:
		if front[0] == "*" and front[1] == "x":
			variable_multiply_variable(position_multiply + number_size + 1)
		else:
			front = '*x' + front
			u_equation_string = back + number_dropped + front
			render_token.delete_all_token()
			render_token.render_all(u_equation_string)

func variable_multiply_variable(x_position: int):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(x_position)
	var front = u_equation_string.right(x_position + 1)
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
			u_equation_string = back + "x**" + power_value + front
		else:
			front = "x**2" + front
			u_equation_string = back + front
	# X DOESN'T HAVE ANY POWER VALUE
	else:
		front = "x**2"
		u_equation_string = back + front
	render_token.delete_all_token()
	render_token.render_all(u_equation_string)

func subtract_number_by_one(number_subtract: String, position_subtract: int):
	u_equation_string = u_equation_string.replace(" ", "")
	var size = number_subtract.length()
	var back = u_equation_string.left(position_subtract)
	var front = u_equation_string.right(position_subtract + size)
	var new_value = str(int(number_subtract) - 1)
	if new_value == "0":
		if not back.empty():
			var index = back.length() - 1
			var parenthesis_counter := 0
			while index >= 0:
				if parenthesis_counter == 0 and (back[index] == "+" or back[index] == "-"):
					break
				elif back[index] == ")":
					parenthesis_counter += 1
				elif back[index] == "(":
					parenthesis_counter -= 1
				else:
					back[index] = ""
				index -= 1
		if not front.empty():
			var index = 0
			var parenthesis_counter := 0
			while index < front.length():
				if parenthesis_counter == 0 and (front[index] == "+" or front[index] == "-"):
					break
				elif front[index] == ")":
					parenthesis_counter -= 1
				elif front[index] == "(":
					parenthesis_counter += 1
				else:
					front[index] = ""
				index += 1
		back[-1] = ""
		u_equation_string = back + front
	elif new_value == "1":
		if front.empty():
			u_equation_string = back + new_value + front
		else:
			if front[0] == "*":
				new_value = ""
				front[0] = ""
			u_equation_string = back + front
		if not back.empty() and back[-1] == "*" and back[-2] == "*":
			back = back.left(back.length() - 2)
			u_equation_string = back + front
	else:
		u_equation_string = back + new_value + front
	
	render_token.delete_all_token()
	render_token.render_all(u_equation_string)

func subtract_variable_by_one(x_position : int):
	u_equation_string = u_equation_string.replace(" ", "")
	var back = u_equation_string.left(x_position)
	var front = u_equation_string.right(x_position+1)
	if front.empty():
		if back[-1] == "*":
			front = ""
			back[-1] = ""
		else:
			front = "1"
		u_equation_string = back + front
	else:
		if front[0] == "*" and front[1] == "*":
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
		else:
			back[-1] = ""
			u_equation_string = back + front

	render_token.delete_all_token()
	render_token.render_all(u_equation_string)

func add_value_at_end(value: String):
	u_equation_string = u_equation_string.replace(" ", "")
	if u_equation_string.empty():
		u_equation_string = value
	elif value[0] == "-":
		u_equation_string = u_equation_string + value
	else:
		u_equation_string = u_equation_string + "+" + value
	render_token.delete_all_token()
	render_token.render_all(u_equation_string)


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

func input_get_equation(viewport, event, shape_idx):
	if event is InputEventMouseButton and !u_equation_string.empty() and event.button_index == 1 and event.is_pressed():
		GrabSprite.clone_equation(render_token.get_children(),u_equation_string)

func reset_u():
	u_equation_string = ""
	render_token.delete_all_token()
	render_token.render_all("")
