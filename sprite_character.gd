extends Sprite

const sprites := [preload("res://characters/zero.png"),preload("res://characters/one.png"),
preload("res://characters/two.png"),preload("res://characters/three.png"),
preload("res://characters/four.png"),preload("res://characters/five.png")
,preload("res://characters/six.png"),preload("res://characters/seven.png")
,preload("res://characters/eight.png"),preload("res://characters/nine.png")
,preload("res://characters/x.png"),preload("res://characters/plus_sign.png"),preload("res://characters/minus_sign.png"),
preload("res://characters/equal.png"),preload("res://characters/left_bracket.png"),
preload("res://characters/right_bracket.png"), preload("res://characters/c.png"),
preload("res://characters/sin.png"),preload("res://characters/cos.png"),preload("res://characters/tan.png"),
preload("res://characters/cot.png"),preload("res://characters/csc.png"), preload("res://characters/sec.png"),
preload("res://characters/ln.png"),preload("res://characters/e.png")]

var character := ""

func _ready():
	match character:
		"0":texture = sprites[0]
		"1":texture = sprites[1]
		"2":texture = sprites[2]
		"3":texture = sprites[3]
		"4":texture = sprites[4]
		"5":texture = sprites[5]
		"6":texture = sprites[6]
		"7":texture = sprites[7]
		"8":texture = sprites[8]
		"9":texture = sprites[9]
		"x":texture = sprites[10]
		"+":texture = sprites[11]
		"-":texture = sprites[12]
		"=":texture = sprites[13]
		"(":texture = sprites[14]
		")":texture = sprites[15]
		"c":texture = sprites[16]
		"sin":texture = sprites[17]
		"cos":texture = sprites[18]
		"tan":texture = sprites[19]
		"cot":texture = sprites[20]
		"csc":texture = sprites[21]
		"sec":texture = sprites[22]
		"ln":texture = sprites[23]
		"e":texture = sprites[24]
