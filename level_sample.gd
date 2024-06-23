extends Node2D

var equation_obj = null

export (int) var num_of_questions := 4
export (int) var rewards_not_completed := 10
export (int) var rewards_completed := 2
export (int) var level_dictionary_check := 0

var solved_questions := 0

const level_completed_scence := preload("res://Levels/level_completed.tscn")

onready var level_progress_bar = $level_progress

func _ready():
	equation_obj = get_node("question")

func _evaluate_answer():
	SoundEffects.click_audio_play()
	if equation_obj.evaluate_answer():
		solved_questions += 1
		update_progress_bar()
		if solved_questions == num_of_questions:
			var obj = level_completed_scence.instance()
			if GameLevelProgress.chap_1_level_progress[level_dictionary_check].completed:
				obj.reward_text = str(rewards_completed)
			else:
				obj.reward_text = str(rewards_not_completed)
			add_child(obj)
		else:
			equation_obj.generate_new_equation()
		var u_sub = get_node_or_null("u-sub")
		if u_sub:
			u_sub.empty_storage()
	else:
		equation_obj.make_all_equation_shake()

func _reset_equation():
	SoundEffects.click_audio_play()
	equation_obj.revert_to_original()

func _on_player_rectangle_get_all_characters():
	var characters = get_node("player_rectangle").get_overlapping_areas()

func update_progress_bar() -> void:
	level_progress_bar.value = float(solved_questions) * 100 / float(num_of_questions)
