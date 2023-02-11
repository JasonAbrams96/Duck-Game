extends KinematicBody2D

var points = 50

var motion = Vector2()
var speed = 50
var dir = 1

func _physics_process(delta):
	
	if is_on_wall() or $RayCast2D.enabled and !$RayCast2D.is_colliding() :
		dir *= -1
		$RayCast2D.position.x *= -1
	
	motion.x = speed * dir
	
	if !is_on_floor():
		motion.y += Global.GRAVITY
	elif is_on_floor():
		motion.y = 0
		if $RayCast2D.enabled == false:
			$RayCast2D.enabled = true
		
	motion = move_and_slide(motion, Vector2.UP)

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		body.jump(1)
		body.hurt(1)

func _on_hurt_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(1)
