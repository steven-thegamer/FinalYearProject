extends Node2D
class_name fraction

var numerator : String = ""
var denumerator : String = ""

var longest_length = 0

onready var fraction_line = $Sprite
onready var num_obj = $numerator
onready var denum_obj = $denumerator

func _ready():
	if "**" in denumerator:
		denum_obj.position.y = 64
	var num_arr = num_obj.parse_tokens(num_obj.tokenize(numerator))
	var denum_arr = denum_obj.parse_tokens(denum_obj.tokenize(denumerator))
	var num_vector : Vector2 = num_obj.render_tokens(num_arr,num_obj.position.x, num_obj.position.y, 0)
	var num_length = num_vector.x
	var char_index_equation = num_vector.y
	var denum_vector = denum_obj.render_tokens(denum_arr,denum_obj.position.x, denum_obj.position.y,char_index_equation+1)
	var denum_length = denum_vector.x
	longest_length = max(num_length,denum_length)
	if longest_length == num_length:
		fraction_line.scale.x = num_length
		# CREATE GAP
		var gap = longest_length - denum_length
		denum_obj.position.x += gap/2
	elif longest_length == denum_length:
		fraction_line.scale.x = denum_length
		# CREATE GAP
		var gap = longest_length - num_length
		num_obj.position.x += gap/2

func add_equation_to_numerator(value : String):
	numerator = numerator + "+" + value
	get_parent().equation_string = get_parent().equation_string.replace(" ","")
	

func add_equation_to_denominator():
	pass
