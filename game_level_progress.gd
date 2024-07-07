extends Node

var chap_1_level_progress := {1:{"completed" : true, "unlocked" : true, "fast_learner" : true},
					2:{"completed" : true, "unlocked" : true, "fast_learner" : true},
					3:{"completed" : true, "unlocked" : true, "fast_learner" : true},
					4:{"completed" : true, "unlocked" : true, "fast_learner" : true},
					5:{"completed" : true, "unlocked" : true, "fast_learner" : true},
					6:{"completed" : true, "unlocked" : true, "fast_learner" : true},
					7:{"completed" : true, "unlocked" : true, "fast_learner" : true},
					8:{"completed" : true, "unlocked" : true, "fast_learner" : true},
					9:{"completed" : true, "unlocked" : true, "fast_learner" : true},
					10:{"completed" : true, "unlocked" : true, "fast_learner" : true},}

var shop_item_inventory := []

var current_level := ""

var money := 0

var paper_background : Color = Color.white

const transition_object := preload("res://transition.tscn")
signal transition_done

func transition_enter():
	var obj = transition_object.instance()
	obj.transition_type = 1
	add_child(obj)
	yield(get_tree().create_timer(0.5),"timeout")
	emit_signal("transition_done")

func transition_exit():
	var obj = transition_object.instance()
	obj.transition_type = 0
	add_child(obj)
	yield(get_tree().create_timer(0.5),"timeout")
	emit_signal("transition_done")
