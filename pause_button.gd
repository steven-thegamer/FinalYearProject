extends TextureButton

const pause_menu := preload("res://pause_screen.tscn")

func _on_pause_button_pressed():
	SoundEffects.click_audio_play()
	get_parent().add_child(pause_menu.instance())
