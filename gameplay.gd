extends Node2D

onready var easy_questions := preload("res://derivatives/easy_derivative_question.tscn")

func _ready():
	pass # Replace with function body.

func generate_question():
	var obj = easy_questions.instance()
	obj.scale = Vector2(0.5,0.5)
	obj.position = Vector2(rand_range(256,768),rand_range(160,480))
	add_child(obj)


func _on_Timer_timeout():
	generate_question()
