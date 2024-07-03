extends Timer

var total_timer := 0.0

func start_game_timer():
	total_timer = 0.0
	start()

func _on_GamePlayTimer_timeout():
	total_timer += 0.1

func get_total_timer() -> float:
	return total_timer

func stop_timer():
	stop()
