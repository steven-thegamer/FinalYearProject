extends "res://level_sample.gd"

var on_tutorial := true

func _ready():
	if GameLevelProgress.chap_1_level_progress[level_dictionary_check].completed:
		on_tutorial = false
		$tutorial_slides.queue_free()

func _on_tutorial_slides_tree_exiting():
	on_tutorial = false
