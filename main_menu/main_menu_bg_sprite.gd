extends KinematicBody2D

var velocity : Vector2

const velocity_values := [-200,-100,-50,50,100,200]

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	velocity = Vector2(velocity_values[rng.randi() % velocity_values.size()], velocity_values[rng.randi() % velocity_values.size()])

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
