extends Node2D

func _on_play_game_button_up():
	SoundEffects.click_audio_play()
	get_tree().change_scene("res://Levels/Level Selection/level_selection_scene.tscn")


func _on_settings_game_button_up():
	SoundEffects.click_audio_play()


func _on_quit_game_button_up():
	SoundEffects.click_audio_play()
	get_tree().quit()
