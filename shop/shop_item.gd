extends Control
class_name shop_item_button

export (String) var item_name
export (String) var item_description
export (int) var price
export (bool) var bought

onready var button = $shop_button
onready var label_desc = $labels/description
onready var label_price = $labels/price
onready var label_title = $labels/title

func _ready():
	if GameLevelProgress.money < price:
		button.disabled = true
	label_title.text = item_name
	label_desc.text = item_description
	label_price.text = "Price: " + str(price)
	if bought:
		label_price.queue_free()
