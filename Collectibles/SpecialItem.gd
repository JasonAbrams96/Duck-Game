extends KinematicBody2D

var score = 300
var velocity = Vector2()
var direction = -1
var in_jump = false

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.collect("special",0, score)
		queue_free()

func _physics_process(delta):
	
	if is_on_wall():
		direction *= -1
	velocity.x = 100*direction

	if is_on_floor():
		velocity.y = -500

	if !is_on_floor():
		velocity.y += Global.GRAVITY
	
	var snap = Vector2.DOWN * 32 if !in_jump else Vector2.ZERO
	velocity = move_and_slide(velocity, Vector2.UP)
	
