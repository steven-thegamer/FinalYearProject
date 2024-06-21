extends shop_button

func _on_shop_item_button_up():
	if !bought:
		bought = true
		label_price.queue_free()
	GameLevelProgress.paper_background = Color(255,178,255)
