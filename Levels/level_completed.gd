extends Node2D

func _on_continue_pressed():
	match GameLevelProgress.current_level:
		"level1":
			GameLevelProgress.chap_1_level_progress[2].unlocked = true
			GameLevelProgress.chap_1_level_progress[1].completed = true
		"level2":
			pass
		"level3":
			pass
		"level4":
			pass
		"level5":
			pass
		"level6":
			pass
		"level7":
			pass
		"level8":
			pass
		"level9":
			pass
		"level10":
			pass
	get_tree().change_scene("res://Levels/Level Selection/level_selection_scene.tscn")
