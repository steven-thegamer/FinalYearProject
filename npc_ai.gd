extends Node2D

const emotion_dict_convert_to_anim := {
	0:"default",
	1:"happy",
	2:"sad",
	3:"angry",
	4:"confused"
}

const particle_colors_dict := {
	0 : Color(0.627451, 1, 0.458824),
	1 : Color(1, 1, 0.458824),
	2 : Color(0.458824, 1, 1),
	3 : Color(1, 0.458824, 0.458824),
	4 : Color(1, 0.698039, 1)
}

onready var sprite = $AnimatedSprite
onready var label = $Label
onready var particles = $CPUParticles2D

signal talking_is_done
signal next_line

const character_per_second := 12.0

var skip := false
var talk_is_done := false

func _ready():
	pass
#	talking_array(NpcTalkingGlobal.ai_talking_lines[1],NpcTalkingGlobal.ai_talking_emotions[1])

func _process(delta):
	particles.emitting = visible

func _input(event):
	if Input.is_action_just_pressed("mouse_click"):
		if talk_is_done:
			emit_signal("next_line")
		elif not skip:
			skip = true
	

func talking_array(talking_script : Array, emotion_script : Array):
	var size = talking_script.size()
	for i in range(size):
		talking(talking_script[i],emotion_script[i])
		yield(self,"talking_is_done")
		yield(self,"next_line")
		reset_talking_variables()

func reset_talking_variables():
	label.text = ""
	skip = false

func talking(text : String, emotion : int):
	talk_is_done = false
	sprite.play(emotion_dict_convert_to_anim[emotion])
	particles.color = particle_colors_dict[emotion]
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
