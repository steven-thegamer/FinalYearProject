extends CPUParticles2D

func _on_Tween_tween_completed(object, key):
	emitting = false
	yield(get_tree().create_timer(2.5),"timeout")
	queue_free()
