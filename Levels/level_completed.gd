extends Node2D

onready var label = $HSplitContainer/Label
var reward_text := "10"

func _ready():
	label.text = "Reward: " + reward_text
	GameLevelProgress.money += int(reward_text)

func _on_continue_pressed():
	match GameLevelProgress.current_level:
		"level1":
			GameLevelProgress.chap_1_level_progress[2].unlocked = true
			GameLevelProgress.chap_1_level_progress[1].completed = true
		"level2":
			GameLevelProgress.chap_1_level_progress[3].unlocked = true
			GameLevelProgress.chap_1_level_progress[2].completed = true
		"level3":
			GameLevelProgress.chap_1_level_progress[4].unlocked = true
			GameLevelProgress.chap_1_level_progress[3].completed = true
		"level4":
			GameLevelProgress.chap_1_level_progress[5].unlocked = true
			GameLevelProgress.chap_1_level_progress[4].completed = true
		"level5":
			GameLevelProgress.chap_1_level_progress[6].unlocked = true
			GameLevelProgress.chap_1_level_progress[5].completed = true
		"level6":
			GameLevelProgress.chap_1_level_progress[7].unlocked = true
			GameLevelProgress.chap_1_level_progress[6].completed = true
		"level7":
			GameLevelProgress.chap_1_level_progress[8].unlocked = true
			GameLevelProgress.chap_1_level_progress[7].completed = true
		"level8":
			GameLevelProgress.chap_1_level_progress[9].unlocked = true
			GameLevelProgress.chap_1_level_progress[8].completed = true
		"level9":
			GameLevelProgress.chap_1_level_progress[10].unlocked = true
			GameLevelProgress.chap_1_level_progress[9].completed = true
	GameLevelProgress.transition_exit()
	yield(GameLevelProgress,"transition_done")
	get_tree().change_scene("res://Levels/Level Selection/level_selection_scene.tscn")
