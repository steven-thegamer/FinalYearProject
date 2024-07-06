extends TextureButton

var active := false

onready var u = $u_render
onready var v = $v_render


func _ready():
	u.hide()
	v.hide()

func _on_uv_sub_pressed():
	active = !active
	u.visible = active
	v.visible = active

func reset_values():
	u.u_equation_string = ""
	v.u_equation_string = ""
	u.render_token.delete_all_token()
	v.render_token.delete_all_token()
	u.render_token.render_all("")
	v.render_token.render_all("")
