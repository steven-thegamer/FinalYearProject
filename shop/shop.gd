extends Control

signal close_shop

var page := 1

const min_page := 1
const max_page := 2

onready var vboxcontainers := [
	get_node("VBoxContainer"),
	get_node("VBoxContainer2"),
	get_node("VBoxContainer3"),
	get_node("VBoxContainer4"),
]

onready var left_button = $left_page
onready var right_button = $right_page

func _ready():
	pass # Replace with function body.

func _process(delta):
	left_button.disabled = true if page == min_page else false
	
	right_button.disabled = true if page == max_page else false

func _on_back_pressed():
	emit_signal("close_shop")

func _on_left_page_pressed():
	page -= 1
	hide_all_vbox_and_display()

func _on_right_page_pressed():
	page += 1
	hide_all_vbox_and_display()

func hide_all_vbox_and_display():
	for container in vboxcontainers:
		container.hide()
	match page:
		1:
			$VBoxContainer.show()
			$VBoxContainer2.show()
		2:
			$VBoxContainer3.show()
			$VBoxContainer4.show()
