extends Node2D

func _on_continue_pressed():
	queue_free()

func _on_exit_pressed():
	GameLevelProgress.transition_exit()
	yield(GameLevelProgress,"transition_done")
	get_tree().change_scene("res://Levels/Level Selection/level_selection_scene.tscn")
