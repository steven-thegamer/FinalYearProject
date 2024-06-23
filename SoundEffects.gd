extends Node2D

const drop_sfx := preload("res://MusicAndSoundEffects/drop_character.wav")
const click_sfx := preload("res://MusicAndSoundEffects/normal_click.wav")
const select_sfx := preload("res://MusicAndSoundEffects/select_character.wav")

func drop_audio_play():
	var obj = AudioStreamPlayer2D.new()
	obj.stream = drop_sfx
	add_child(obj)
	obj.global_position = get_global_mouse_position()
	obj.play()
	obj.connect("finished",self,"destroy_audio",[obj])

func click_audio_play():
	var obj = AudioStreamPlayer2D.new()
	obj.stream = click_sfx
	add_child(obj)
	obj.global_position = get_global_mouse_position()
	obj.play()
	obj.connect("finished",self,"destroy_audio",[obj])

func select_audio_play():
	var obj = AudioStreamPlayer2D.new()
	obj.stream = select_sfx
	add_child(obj)
	obj.global_position = get_global_mouse_position()
	obj.play()
	obj.connect("finished",self,"destroy_audio",[obj])

func destroy_audio(node : Node2D):
	node.queue_free()
