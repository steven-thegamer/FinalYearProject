extends Node2D

var numerator : String = ""
var denumerator : String = ""

var longest_length = 0

onready var fraction_line = $Sprite
onready var num_obj = $numerator
onready var denum_obj = $denumerator

func _ready():
	if "**" in denumerator:
		denum_obj.position.y = 64
	var num_arr = num_obj.tokenize(numerator)
	var denum_arr = denum_obj.tokenize(denumerator)
	var num_length = num_obj.render_tokens(num_arr)
	var denum_length = denum_obj.render_tokens(denum_arr)
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
