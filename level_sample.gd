extends Node2D

var equation_obj = null

export (int) var num_of_questions := 4
export (int) var rewards_not_completed := 10
export (int) var rewards_completed := 2
export (int) var level_dictionary_check := 0

var solved_questions := 0

const level_completed_scence := preload("res://Levels/level_completed.tscn")
const particle_complete := preload("res://add_progress.tscn")
const initial := preload("res://initial_add_progress.tscn")

onready var level_progress_bar = $level_progress
onready var uv = $uv_sub

func _ready():
	randomize()
	equation_obj = get_node("question")
	GamePlayTimer.start_game_timer()
	get_node("NinePatchRect").modulate = GameLevelProgress.paper_background
	GameLevelProgress.transition_enter()
	yield(GameLevelProgress,"transition_done")

func _evaluate_answer():
	SoundEffects.click_audio_play()
	if equation_obj.evaluate_answer():
		solved_questions += 1
		update_progress_bar()
		create_particle_to_progress_bar()
		if solved_questions == num_of_questions:
			var obj = level_completed_scence.instance()
			if GameLevelProgress.chap_1_level_progress[level_dictionary_check].completed:
				obj.reward_text = str(rewards_completed)
			else:
				obj.reward_text = str(rewards_not_completed)
				if NpcTalkingGlobal.ai_talking_lines.has(level_dictionary_check):
					NpcTalkingGlobal.will_talk = true
					NpcTalkingGlobal.dialogue_number = level_dictionary_check
			GamePlayTimer.stop_timer()
			if GamePlayTimer.get_total_timer() < 600.0:
				GameLevelProgress.chap_1_level_progress[level_dictionary_check].fast_learner = true
			add_child(obj)
			uv.reset_values()
		else:
			get_node("evaluate_button").play_correct()
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

func create_particle_to_progress_bar():
	var obj_2 = initial.instance()
	obj_2.position = equation_obj.position
	add_child(obj_2)
	var obj = particle_complete.instance()
	obj.position = equation_obj.position
	yield(get_tree().create_timer(0.75),"timeout")
	add_child(obj)
	obj.get_node("Tween").interpolate_property(obj,"position",obj.position,level_progress_bar.rect_position,1.0,Tween.TRANS_BOUNCE,Tween.EASE_IN_OUT)
	obj.get_node("Tween").start()
