extends shop_item_button

func _on_shop_button_pressed():
	buy_item()
	GameLevelProgress.paper_background = Color8(45,210,255)
