extends shop_item_button

const cursor := preload("res://shop/Mouse Cursor/custom_cursor3.png")

func _on_shop_button_pressed():
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(24,24))
