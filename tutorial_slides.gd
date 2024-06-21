extends Node2D

onready var tutorial_slides = $Tutorial1
onready var front_arrow := $forward
onready var back_arrow := $backward
var max_slides : int = 0

func _ready():
	max_slides = tutorial_slides.get_sprite_frames().get_frame_count("tutorial1")

func _on_forward_pressed():
	if tutorial_slides.frame < max_slides - 1:
		tutorial_slides.frame += 1
		if back_arrow.visible == false:
			back_arrow.show()
	else:
		queue_free()

func _on_backward_pressed():
	tutorial_slides.frame -= 1
	if tutorial_slides.frame == 0:
		back_arrow.hide()
