extends TextureButton

onready var sfx = $AudioStreamPlayer2D

func play_correct():
	sfx.play()
