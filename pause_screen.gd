extends Node2D

onready var review_tutorial := $TutorialPopUp

func _on_continue_pressed():
	queue_free()

func _on_exit_pressed():
	GameLevelProgress.transition_exit()
	yield(GameLevelProgress,"transition_done")
	get_tree().change_scene("res://Levels/Level Selection/level_selection_scene.tscn")


func _on_review_pressed():
	review_tutorial.show()


func _on_close_pressed():
	review_tutorial.hide()

func _on_TutorialPopUp_visibility_changed():
	if GameLevelProgress.chap_1_level_progress[1].unlocked:
		$TutorialPopUp/VBoxContainer/TextureRect.show()
	if GameLevelProgress.chap_1_level_progress[2].unlocked:
		$TutorialPopUp/VBoxContainer/TextureRect2.show()
	if GameLevelProgress.chap_1_level_progress[4].unlocked:
		$TutorialPopUp/VBoxContainer/TextureRect3.show()
	if GameLevelProgress.chap_1_level_progress[6].unlocked:
		$TutorialPopUp/VBoxContainer/TextureRect4.show()
	if GameLevelProgress.chap_1_level_progress[8].unlocked:
		$TutorialPopUp/VBoxContainer/TextureRect5.show()
