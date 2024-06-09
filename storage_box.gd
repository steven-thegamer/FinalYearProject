extends Area2D

var is_stored := false

const character_display = preload("res://characters_display_only.tscn")
onready var rectangle_mouse_highlight = $player_rectangle

export (NodePath) var equation_path
onready var equation_obj = get_node(equation_path)

onready var display_copy = $display_copy

var characters_highlighted_arr := []
var stored_value := ""

func _on_storage_box_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if not event.is_pressed() and not is_stored:
			rectangle_mouse_highlight.activate()
		elif event.is_pressed() and is_stored:
			GrabSprite.clone_equation(characters_highlighted_arr,stored_value)

func check_validity(char_array : Array) -> bool:
	var front_char = char_array[0]
	var last_char = char_array[-1]
	if front_char.type == front_char.character_type.OPERATOR or last_char.type == last_char.character_type.OPERATOR:
		return false
	return true

func _on_player_rectangle_get_all_characters():
	is_stored = true
	characters_highlighted_arr = rectangle_mouse_highlight.get_overlapping_areas()
	if check_validity(characters_highlighted_arr):
		var characters_highlighted_size = characters_highlighted_arr.size()
		var eq_string = equation_obj.equation_string.replace(" ","")
		stored_value = eq_string.substr(characters_highlighted_arr[0].char_pos_in_string,characters_highlighted_arr[-1].char_pos_in_string-characters_highlighted_arr[0].char_pos_in_string + 1)
		clone_all_children(characters_highlighted_arr)
	else:
		is_stored = false
		characters_highlighted_arr = []

func clone_all_children(characters_cloned : Array):
	var arr_size = characters_cloned.size()
	var distance = 0
	for index in range(arr_size):
		var obj = characters_cloned[index].duplicate()
		if index == 0:
			distance = obj.position
		obj.position = obj.position - distance
		display_copy.add_child(obj)

func empty_storage():
	is_stored = false
	stored_value = ""
	characters_highlighted_arr = []
