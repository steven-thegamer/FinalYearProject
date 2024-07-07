extends Node2D

onready var tutorial_slides = $Tutorial1
onready var front_arrow := $forward
onready var back_arrow := $backward
var max_slides : int = 0

export var tutorial_type : String

func _ready():
	tutorial_slides.play(tutorial_type)
	max_slides = tutorial_slides.get_sprite_frames().get_frame_count(tutorial_type)

func _on_forward_pressed():
	if tutorial_slides.frame < max_slides - 1:
		tutorial_slides.frame += 1
		if back_arrow.visible == false:
			back_arrow.show()
		$Tutorial1/multiply_tutorial_animation.visible = true if tutorial_slides.animation == "tutorial1" and tutorial_slides.frame == 1 else false
		$Tutorial1/subtract_tutorial_animation.visible = true if tutorial_slides.animation == "tutorial1" and tutorial_slides.frame == 1 else false
		$Tutorial1/u_sub_tutorial_animation.visible = true if tutorial_slides.animation == "tutorial3" and tutorial_slides.frame == 1 else false
	else:
		queue_free()

func _on_backward_pressed():
	tutorial_slides.frame -= 1
	if tutorial_slides.frame == 0:
		back_arrow.hide()
	$Tutorial1/multiply_tutorial_animation.visible = true if tutorial_slides.animation == "tutorial1" and tutorial_slides.frame == 1 else false
	$Tutorial1/subtract_tutorial_animation.visible = true if tutorial_slides.animation == "tutorial1" and tutorial_slides.frame == 1 else false
	$Tutorial1/u_sub_tutorial_animation.visible = true if tutorial_slides.animation == "tutorial3" and tutorial_slides.frame == 1 else false
