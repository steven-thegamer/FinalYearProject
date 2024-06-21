extends Node2D

var original_equation_string := ""
var equation_string := ""
var target_string := ""
var other_possible_targets := []

func revert_to_original():
	equation_string = original_equation_string
	get_node("render_token").delete_all_token()
	get_node("render_token").render_all(equation_string)

func _on_equation_question_created():
	equation_string = get_node("equation").question
	original_equation_string = equation_string
	target_string = get_node("equation").answer
	get_node("render_token").render_all(equation_string)

func multiply_trigonometry_equation_string(position_multiply : int, string_multiply : String):
	equation_string = equation_string.replace(" ","")
	var back = equation_string.left(position_multiply)
	var parenthesis_counter = 0
	var inside_trig_function := ""
	var limit_front = 0
	for i in range(position_multiply + 3,equation_string.length()):
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
	var full_trig_function = equation_string.substr(position_multiply,3) + inside_trig_function
	var multiplier_trig = string_multiply + inside_trig_function
	var front = equation_string.right(limit_front)
	equation_string = back + multiplier_trig + "*" + full_trig_function + front
	print(equation_string)
	get_node("render_token").delete_all_token()
	equation_string = get_node("equation").sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func multiply_number_equation_string(value : String , position_multiply : int, multiply_value : String):
	equation_string = equation_string.replace(" ","")
	var size = value.length()
	var back = equation_string.left(position_multiply)
	var front = equation_string.right(position_multiply + size)
	var new_value = str(int(value) * int(multiply_value))
	equation_string = back + new_value + front
	get_node("render_token").delete_all_token()
	equation_string = get_node("equation").sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func subtract_number_equation_string(value : String , position_subtract : int):
	equation_string = equation_string.replace(" ","")
	var size = value.length()
	var back = equation_string.left(position_subtract)
	var front = equation_string.right(position_subtract + size)
	var new_value = str(int(value) - 1)
	equation_string = back + new_value + front
	get_node("render_token").delete_all_token()
	equation_string = get_node("equation").sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func multiply_trigonometry_on_equation_string(trigonometry_position : int, multiply_value : String):
	equation_string = equation_string.replace(" ","")
	var back = equation_string.left(trigonometry_position)
	var front = equation_string.right(trigonometry_position)
	equation_string = back + multiply_value + "*" + front
	get_node("render_token").delete_all_token()
	equation_string = get_node("equation").sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func update_equation_string_on_trigonometry(trigonometry_position : int, power_value : String):
	equation_string = equation_string.replace(" ","")
	var back = equation_string.left(trigonometry_position)
	var trigonomety_equation = ""
	var front_limit_position = 0
	var parenthesis_counter = 0
	for i in range(trigonometry_position,equation_string.length()):
		if equation_string[i] == "(":
			trigonomety_equation += equation_string[i]
			parenthesis_counter += 1
		elif equation_string[i] == ")":
			trigonomety_equation += equation_string[i]
			parenthesis_counter -= 1
			if parenthesis_counter == 0:
				front_limit_position = i+1
				break
		else:
			trigonomety_equation += equation_string[i]
	var front = equation_string.right(front_limit_position)
	equation_string = back + "(" + trigonomety_equation + "**" + power_value + ")" + front
	get_node("render_token").delete_all_token()
	equation_string = get_node("equation").sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func switch_trigonometry_on_equation_string(trigonometry_position : int, trig_value : String):
	equation_string = equation_string.replace(" ","")
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
	equation_string = get_node("equation").sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func update_equation_string_on_x(x_position : int):
	equation_string = equation_string.replace(" ","")
	if x_position + 1 < equation_string.length() and equation_string[x_position + 1] == "*" and equation_string[x_position + 2] == "*":
		var power_x_value = equation_string[x_position + 3]
		var new_power_value = str(int(power_x_value) - 1)
		var back = equation_string.left(x_position+3)
		var front = equation_string.right(x_position + 4)
		equation_string = back + new_power_value + front
		get_node("render_token").delete_all_token()
		equation_string = get_node("equation").sympify_equation(equation_string)
		get_node("render_token").render_all(equation_string)
	else:
		var back = equation_string.left(x_position)
		var front = equation_string.right(x_position + 1)
		equation_string = back + "1" + front
		get_node("render_token").delete_all_token()
		equation_string = get_node("equation").sympify_equation(equation_string)
		get_node("render_token").render_all(equation_string)

func update_equation_string_on_x_multiply(x_position : int, value : String):
	equation_string = equation_string.replace(" ","")
	if x_position > 0 and equation_string[x_position-1] == "*":
		var back = equation_string.left(x_position)
		var front = equation_string.right(x_position + 1)
		equation_string = back + value + "*x" + front
		get_node("render_token").delete_all_token()
		equation_string = get_node("equation").sympify_equation(equation_string)
		get_node("render_token").render_all(equation_string)
	else:
		var back = equation_string.left(x_position)
		var front = equation_string.right(x_position + 1)
		equation_string = back + value + "*x" + front
		get_node("render_token").delete_all_token()
		equation_string = get_node("equation").sympify_equation(equation_string)
		get_node("render_token").render_all(equation_string)

func update_equation_string_logarithm(character : String, log_pos : int, value : String):
	equation_string = equation_string.replace(" ","")
	var back = equation_string.left(log_pos)
	var front = equation_string.right(log_pos + 3)
	if character == "e":
		equation_string = back + value + "*exp" + front
	elif character == "ln":
		equation_string = back + value + "*log" + front
	get_node("render_token").delete_all_token()
	equation_string = get_node("equation").sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)
		
func convert_ln_to_fraction(log_pos : int):
	equation_string = equation_string.replace(" ","")
	var back = equation_string.left(log_pos)
	var front = equation_string.right(log_pos + 3)
	equation_string = back + "1/" + front
	get_node("render_token").delete_all_token()
	equation_string = get_node("equation").sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func equation_string_switch_operator(character: String, operator_pos : int, another_character : String):
	equation_string = equation_string.replace(" ","")
	var back = equation_string.left(operator_pos)
	var front = equation_string.right(operator_pos)
	equation_string = back + another_character + front
	print(equation_string)
	get_node("render_token").delete_all_token()
	equation_string = get_node("equation").sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)

func multiply_value_with_equation(equation: String, value_pos : int, character_hovered_at : String):
	equation_string = equation_string.replace(" ","")
	if character_hovered_at == ")":
		var back = equation_string.left(value_pos+1)
		var front = equation_string.right(value_pos+1)
		equation_string = back + "*(" + equation + ")" + front
	else:
		var back = equation_string.left(value_pos)
		var front = equation_string.right(value_pos)
		equation_string = back + "(" + equation + ")*" + front
	get_node("render_token").delete_all_token()
	equation_string = get_node("equation").sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)
	GrabSprite.emit_signal("equation_u_sub")

func evaluate_answer():
	return equation_string == target_string or other_possible_targets.has(equation_string)

func generate_new_equation():
	get_node("render_token").delete_all_token()
	get_node("equation").generate_new_question()

func make_all_equation_shake():
	for child in get_node("render_token").get_children():
		child.shake_anim()

func add_value_at_end(value : String):
	equation_string = equation_string.replace(" ","")
	equation_string = equation_string + "+" + value
	get_node("render_token").delete_all_token()
	equation_string = get_node("equation").sympify_equation(equation_string)
	get_node("render_token").render_all(equation_string)
