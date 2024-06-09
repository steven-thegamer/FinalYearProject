extends TextureButton

const pause_menu := preload("res://pause_screen.tscn")

func _on_pause_button_pressed():
	get_parent().add_child(pause_menu.instance())
