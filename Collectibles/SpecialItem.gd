extends KinematicBody2D

var score = 300
var velocity = Vector2()
var direction = -1
var in_jump = false
var num = 0

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.collect("special",num, score)
		Global.create_sfx_audio("res://Assets/Audio/sfx_coin_double1.wav", get_tree().current_scene)
		queue_free()

func _physics_process(delta):
	
	if is_on_wall():
		direction *= -1
	velocity.x = 100*direction

	if is_on_floor():
		velocity.y = -500

	if !is_on_floor():
		velocity.y += Global.GRAVITY
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
