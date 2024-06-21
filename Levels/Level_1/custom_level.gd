extends "res://level_sample.gd"

var on_tutorial := true


func _on_tutorial_slides_tree_exiting():
	on_tutorial = false
