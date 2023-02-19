extends KinematicBody2D

var player = null

var can_fall = false
var velocity = Vector2()

func _process(delta):
	if global_position.y > 403:
		queue_free()
		
func _physics_process(delta):
	
	if can_fall:
		velocity.y = 75
		velocity.y += Global.GRAVITY * delta
		move_and_slide(velocity)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player = body
		$Timer.start()
		
func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player = null
		can_fall = false
		$Timer.stop()

func _on_Timer_timeout():
	$Timer.stop()
	can_fall = true
