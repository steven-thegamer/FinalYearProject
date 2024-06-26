extends Area2D

const rectangle_color = Color(0,0.5,0.5,0.5)
onready var collision_shape = $CollisionShape2D
var active := false
var starting_mouse_pos : Vector2
var collider_shape : RectangleShape2D
var end_mouse_pos : Vector2
var start_drawing := false
var mouse_rect = Rect2()

signal get_all_characters

func _ready():
	collider_shape = get_node("CollisionShape2D").shape
	reset()

func reset():
	collider_shape.extents = Vector2()

func _input(event):
	if active and event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.is_pressed() and not start_drawing:
			starting_mouse_pos = get_local_mouse_position()
			start_drawing = true
		elif not event.is_pressed():
			active = false
			mouse_rect = Rect2()
			if get_overlapping_characters().size() > 0:
				emit_signal("get_all_characters")
			start_drawing = false
	
	if event is InputEventMouseMotion and start_drawing:
		end_mouse_pos = get_local_mouse_position()
		mouse_rect = Rect2(starting_mouse_pos, end_mouse_pos - starting_mouse_pos)
		collider_shape.set_extents(mouse_rect.size / 2)
		collision_shape.position = mouse_rect.get_center()

func get_overlapping_characters() -> Array:
	var result := []
	for child in get_overlapping_areas():
		if child is token:
			result.append(child)
	return result

func _draw():
	draw_rect(mouse_rect, rectangle_color)

func _physics_process(delta):
	update()

func activate() -> void:
	active = true

func deactivate() -> void:
	active = false
