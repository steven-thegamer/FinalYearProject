extends Node2D

onready var label = $textbox
onready var tween = $textbox/Tween

const character_per_second_default := 10

func set_text(value : String):
	label.text = value
	label.percent_visible = 0.0
	play_typewriter_effect(character_per_second_default)

func play_typewriter_effect(char_per_second : float):
	var num_of_chars = label.text.length()
	var time_total = num_of_chars / char_per_second
	tween.interpolate_property(label,"visible_characters",0,num_of_chars,time_total)
	tween.start()
