extends Area2D

var is_stored := false

const character_display = preload("res://characters_display_only.tscn")
const character = preload("res://characters.tscn")

onready var bin = $bin
onready var rectangle_mouse_highlight = $player_rectangle

export (NodePath) var equation_path
onready var equation_obj = get_node(equation_path)

onready var equation = $question

var characters_highlighted_arr := []
var stored_value := ""

func _ready():
	GrabSprite.connect("equation_u_sub",self,"empty_storage")

func _on_storage_box_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if not event.is_pressed() and not is_stored:
			rectangle_mouse_highlight.activate()
		elif event.is_pressed() and is_stored:
			GrabSprite.clone_equation(equation.render_token.get_children(),stored_value)

func check_validity(char_array : Array) -> bool:
	var front_char = char_array[0]
	var last_char = char_array[-1]
	if front_char.name == "addition":
		front_char = char_array[1]
	if last_char.name == "addition":
		last_char = char_array[-2]
	if front_char.type == front_char.character_type.OPERATOR or last_char.type == last_char.character_type.OPERATOR:
		return false
	if (front_char.characters == "(" and last_char.characters != ")") or (front_char.characters != "(" and last_char.characters == ")"):
		return false
	return true

func _on_player_rectangle_get_all_characters():
	is_stored = true
	characters_highlighted_arr = rectangle_mouse_highlight.get_overlapping_areas()
	if check_validity(characters_highlighted_arr):
		if characters_highlighted_arr[-1].name == "addition":
			characters_highlighted_arr.pop_back()
		var eq_string = equation_obj.equation_string.replace(" ","")
		stored_value = eq_string.substr(characters_highlighted_arr[0].char_pos_in_string,characters_highlighted_arr[-1].char_pos_in_string-characters_highlighted_arr[0].char_pos_in_string + 1)
		equation.set_equation_string(stored_value)
		bin.show()
	else:
		is_stored = false
		characters_highlighted_arr = []

func empty_storage():
	is_stored = false
	stored_value = ""
	characters_highlighted_arr = []
	for child in equation.render_token.get_children():
		child.queue_free()
	rectangle_mouse_highlight.mouse_rect = Rect2()
	bin.hide()
