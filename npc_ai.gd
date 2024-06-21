extends Node2D

const emotion_dict_convert_to_anim := {
	0:"default",
	1:"happy",
	2:"sad",
	3:"angry",
	4:"confused"
}
onready var sprite = $AnimatedSprite
onready var label = $Label

signal talking_is_done
signal next_line

const character_per_second := 8.0

var skip := false
var talk_is_done := false
	
func _input(event):
	if event.is_action_pressed("mouse_click") and not skip:
		skip = true
	if event.is_action_pressed("mouse_click") and talk_is_done:
		emit_signal("next_line")
	

func talking_array(talking_script : Array, emotion_script : Array, size : int):
	for i in range(size):
		talking(talking_script[i],emotion_script[i])
		yield(self,"talking_is_done")

func talking(text : String, emotion : int):
	sprite.play(emotion_dict_convert_to_anim[emotion])
	var index = 0
	while label.text != text:
		label.text += text[index]
		yield(get_tree().create_timer(1/character_per_second),"timeout")
		index += 1
		if skip:
			label.text = text
	emit_signal("talking_is_done")

func _on_npc_ai_talking_is_done():
	talk_is_done = true
	sprite.stop()
	sprite.frame = 0
