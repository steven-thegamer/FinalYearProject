extends Node2D

func _on_play_game_button_up():
	get_tree().change_scene("res://Levels/Level Selection/level_selection_scene.tscn")


func _on_settings_game_button_up():
	pass # Replace with function body.


func _on_quit_game_button_up():
	get_tree().quit()
