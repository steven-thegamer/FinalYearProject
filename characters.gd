extends Area2D

var characters : String

const character_sprite = preload("res://sprite_character.tscn")

onready var circle = $Sprite
onready var collision_shape = $CollisionShape2D

func _ready():
	var asteriks_count = characters.count("*")
	var i = 0
	var index = 0
	if characters == "sin" or characters == "cos" or characters == "tan" or characters == "sec" or characters == "csc" or characters == "cot":
		var obj = character_sprite.instance()
		obj.character = characters
		obj.position.x = 32
		add_child(obj)
		circle.position.x = 32
		collision_shape.position = circle.position
		var new_shape = RectangleShape2D.new()
		new_shape.extents = Vector2(40,32)
		get_node("CollisionShape2D").shape = new_shape
	else:
		while i < characters.length():
			if characters[i] == "*":
				if i+1 < characters.length() and characters[i+1] == "*":
					i += 2
					var obj = character_sprite.instance()
					obj.character = characters[i]
					obj.position = Vector2(16+40*index,-32)
					add_child(obj)
					index += 1
			else:
				var obj = character_sprite.instance()
				obj.character = characters[i]
				obj.position.x = 16+40*index
				add_child(obj)
				index += 1
			i += 1
		circle.position.x = (32+40*(index-1))/2
		collision_shape.position = circle.position
		var new_shape = RectangleShape2D.new()
		new_shape.extents = Vector2((32+40*(index-1))/2,32)
		get_node("CollisionShape2D").shape = new_shape
	
func _on_characters_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		circle.visible = !circle.visible

