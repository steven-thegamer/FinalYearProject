extends Node2D

onready var desc = $DescriptionText
onready var tit = $TitleText

var scene_path : String
var level_code_selection : String

func update_text(title_text : String,description_text :  String):
	tit.text = title_text
	desc.bbcode_text = description_text

func _on_Button_pressed():
	if scene_path != "":
		GameLevelProgress.current_level = level_code_selection
		GameLevelProgress.transition_exit()
		yield(GameLevelProgress,"transition_done")
		get_tree().change_scene(scene_path)


func _on_close_button_pressed():
	scene_path = ""
	hide()
