extends TextureButton

export (int) var level_number
export (String) var level_path
var unlocked := false
var completed := false
export (String) var title
export (String) var desc := ""
export (String) var level_code
onready var label = $Label

signal display_title_and_desc(title,desc,path,level_code)

func _ready():
	label.text = str(level_number)
	if not unlocked:
		disabled = true
	if completed:
		var texture_norm = preload("res://levels/levelselection/level_button3.png")
		var texture_hov = preload("res://levels/levelselection/level_button4.png")
		texture_normal = texture_norm
		texture_hover = texture_hov

func _on_level_button_pressed():
	emit_signal("display_title_and_desc",title,desc,level_path,level_code)
