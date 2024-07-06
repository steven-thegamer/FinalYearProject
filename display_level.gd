extends Node2D

onready var desc = $DescriptionText
onready var tit = $TitleText
onready var anim = $AnimationPlayer

var scene_path : String
var level_code_selection : String

const typewriter_speed_per_second := 30.0

func update_text(title_text : String,description_text :  String):
	tit.text = title_text
	desc.bbcode_text = description_text
	desc.percent_visible = 0
	anim.play("show_animation")

func _on_Button_pressed():
	if scene_path != "":
		GameLevelProgress.current_level = level_code_selection
		GameLevelProgress.transition_exit()
		yield(GameLevelProgress,"transition_done")
		get_tree().change_scene(scene_path)

func _on_close_button_pressed():
	scene_path = ""
	hide()

func typewriter_description() -> void:
	while desc.percent_visible < 1:
		desc.visible_characters += 1
		yield(get_tree().create_timer(1.0/typewriter_speed_per_second),"timeout")


func _on_DescriptionText_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		desc.percent_visible = 1
