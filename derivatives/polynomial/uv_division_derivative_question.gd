extends Node2D

onready var eq = $equation
onready var number = $Label

export (bool) var correct = true
export (int) var question_number = 0

func _ready():
	number.text = str(question_number) + "."

func _on_equation_question_created():
	var equation_string = get_node("equation").question
	var answer_string = get_node("equation").answer
	get_node("render_token").render_all(equation_string,answer_string)
	
