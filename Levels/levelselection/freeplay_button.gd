extends TextureButton

export (PackedScene) var level_attached
var unlocked := false
var completed := false

func _ready():
	if not unlocked:
		disabled = true
	if completed:
		var texture_norm = preload("res://levels/levelselection/level_button3.png")
		var texture_hov = preload("res://levels/levelselection/level_button4.png")
		texture_normal = texture_norm
		texture_hover = texture_hov
	
	if level_attached != null:
		connect("button_up",self,"go_to_level")

func go_to_level():
	get_tree().change_scene_to(level_attached)
