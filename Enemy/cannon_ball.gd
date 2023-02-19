extends KinematicBody2D

var velocity = Vector2()
var direction_x = -1
var direction_y = 0
var speed = 200

func _physics_process(delta):
	velocity.x = speed * direction_x
	velocity.y = speed * direction_y
	
	velocity = move_and_slide(velocity)
	


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(1)
		queue_free()
