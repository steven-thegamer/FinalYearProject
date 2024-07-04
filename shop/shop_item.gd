extends Control
class_name shop_item_button

export (String) var item_name
export (String) var item_description
export (int) var price
export (bool) var bought
export (String) var item_id

onready var button = $shop_button
onready var label_desc = $labels/description
onready var label_price = $labels/price
onready var label_title = $labels/title

func _ready():
	label_title.text = item_name
	label_desc.text = item_description
	label_price.text = "Price: " + str(price)
	if GameLevelProgress.shop_item_inventory.has(item_id):
		bought = true
	if bought:
		label_price.queue_free()

func _process(delta):
	button.disabled = true if GameLevelProgress.money < price and not bought else false

func buy_item():
	if not bought:
		bought = true
		label_price.queue_free()
		GameLevelProgress.money -= price
		GameLevelProgress.shop_item_inventory.append(item_id)
