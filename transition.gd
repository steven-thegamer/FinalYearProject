extends CanvasLayer

onready var anim = $AnimationPlayer
var transition_type := 0

func _ready():
	anim.play("transition_enter") if transition_type == 1 else anim.play("transition_exit")

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
