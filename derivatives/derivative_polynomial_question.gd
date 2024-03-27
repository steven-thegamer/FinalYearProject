extends Node2D

onready var eq = $equation
export (bool) var correct = true
export (int) var question_number = 0

onready var number = $Label

func _ready():
	number.text = str(question_number) + "."
	
func _on_equation_question_created():
	var equation_string = get_node("equation").question
	var answer_string = get_node("equation").answer
	if not correct:
		answer_string = make_answer_wrong()
	get_node("render_token").render_all(equation_string,answer_string)

func make_answer_wrong():
	var answer_string = get_node("equation").answer
	var tokenized_answer = get_node("render_token").tokenize(answer_string)
	var wrong_tokenized_answer : Array = get_node("render_token").change_to_wrong(tokenized_answer)
	var string_wrong : String = ""
	for i in wrong_tokenized_answer:
		string_wrong += i
	return string_wrong
