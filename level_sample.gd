extends Node2D

var equation_obj = null

export (int) var num_of_questions := 5
export (bool) var has_time_limit := false
export (float) var time_limit := 0.0

var solved_questions := 0

const level_completed_scence := preload("res://Levels/level_completed.tscn")

func _ready():
	equation_obj = get_node("question")

func _evaluate_answer():
	if equation_obj.evaluate_answer():
		solved_questions += 1
		if solved_questions == num_of_questions:
			var obj = level_completed_scence.instance()
			add_child(obj)
		else:
			equation_obj.generate_new_equation()
	else:
		equation_obj.make_all_equation_shake()

func _reset_equation():
	equation_obj.revert_to_original()

func _on_player_rectangle_get_all_characters():
	var characters = get_node("player_rectangle").get_overlapping_areas()
	
