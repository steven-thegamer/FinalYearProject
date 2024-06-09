extends Area2D

onready var char_sprite_node = $character_sprites

var characters : String

const character_sprite = preload("res://sprite_character.tscn")

func _ready():
	var i = 0
	var index = 0
	if characters == "sin" or characters == "cos" or characters == "tan" or characters == "sec" or characters == "csc" or characters == "cot":
		var obj = character_sprite.instance()
		obj.character = characters
		obj.position.x = 32
		char_sprite_node.add_child(obj)
	elif characters == "ln":
		var obj = character_sprite.instance()
		obj.character = characters
		obj.position.x = 32
		char_sprite_node.add_child(obj)
	else:
		while i < characters.length():
			if characters[i] == "*":
				if i+1 < characters.length() and characters[i+1] == "*":
					i += 2
					var obj = character_sprite.instance()
					obj.character = characters[i]
					obj.position = Vector2(16+40*index,-32)
					char_sprite_node.add_child(obj)
					index += 1
			else:
				var obj = character_sprite.instance()
				obj.character = characters[i]
				obj.position.x = 16+40*index
				char_sprite_node.add_child(obj)
				index += 1
			i += 1
