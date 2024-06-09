extends Node2D

onready var eq = $equation
export (int) var question_number = 0
onready var number = $Label
var equation_string : String = ""
var target_string : String = ""
var inputted_answer := ""

func _ready():
	number.text = str(question_number) + "."
	
func _on_equation_question_created():
	equation_string = get_node("equation").question
	target_string = get_node("equation").answer
	get_node("render_token").render_all(equation_string)

func rerender_question(ori_character : String , position_switch : int, replacement_character : String):
	equation_string = equation_string.replace(" ","")
	var size = ori_character.length()
	var back = equation_string.left(position_switch)
	var front = equation_string.right(position_switch + 1)
	equation_string = back + replacement_character + front
	get_node("render_token").delete_all_token()
	get_node("render_token").render_all(equation_string)
