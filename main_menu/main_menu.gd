extends Node2D

func _ready():
	GameLevelProgress.transition_enter()
	yield(GameLevelProgress,"transition_done")
	$NinePatchRect.modulate = GameLevelProgress.paper_background

func _on_play_game_pressed():
	SoundEffects.click_audio_play()
	GameLevelProgress.transition_exit()
	yield(GameLevelProgress,"transition_done")
	get_tree().change_scene("res://Levels/Level Selection/level_selection_scene.tscn")

func _on_quit_game_pressed():
	SoundEffects.click_audio_play()
	get_tree().quit()
