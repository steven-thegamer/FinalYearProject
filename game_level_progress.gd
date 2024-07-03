extends Node

var chap_1_level_progress := {1:{"completed" : false, "unlocked" : true, "fast_learner" : false},
					2:{"completed" : false, "unlocked" : false, "fast_learner" : false},
					3:{"completed" : false, "unlocked" : false, "fast_learner" : false},
					4:{"completed" : false, "unlocked" : false, "fast_learner" : false},
					5:{"completed" : false, "unlocked" : false, "fast_learner" : false},
					6:{"completed" : false, "unlocked" : false, "fast_learner" : false},
					7:{"completed" : false, "unlocked" : false, "fast_learner" : false},
					8:{"completed" : false, "unlocked" : false, "fast_learner" : false},
					9:{"completed" : false, "unlocked" : false, "fast_learner" : false},
					10:{"completed" : false, "unlocked" : false, "fast_learner" : false},}

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
