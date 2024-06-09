extends Node2D
var timer_time : float = 60.0
var active := true
onready var label = $Label
func _ready():
	label.text = str(timer_time)
func _process(delta):
	if active:
		label.text = str(timer_time)
		if timer_time <= 0:
			active = false
func _on_Timer_timeout():
	timer_time -= 0.1
