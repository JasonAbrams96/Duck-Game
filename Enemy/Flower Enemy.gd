extends KinematicBody2D


var speed = 50
var motion = Vector2()
var dir = 1
var dead = false

var points = 100

func _physics_process(delta):
	
	#Find direction
	if is_on_wall():
		dir *= -1
		scale.x *= -1
	elif !$RayCast2D.is_colliding():
		dir *= -1
		scale.x *= -1
	motion.x = speed * dir
	
	if !is_on_floor():
		motion.y += Global.GRAVITY
	else: 
		motion.y = 0
		
	motion = move_and_slide(motion, Vector2.UP)
	


func _on_HeadArea_body_entered(body):
	if body.is_in_group("player") and not dead:
		body.jump(1)
		dead = true
		set_collision_mask_bit(0, 0)
		$HurtArea.monitoring = false
		$HurtArea2.monitoring = false
		$HeadArea.set_deferred("monitoring", false)
		$AnimatedSprite.play("dead")
		set_physics_process(false)
		PlayerGlobal.score += points
		PlayerGlobal.emit_signal("score_updated", PlayerGlobal.score)
		var expl = Global.explosion_particles.instance()
		expl.my_texture = load("res://Assets/flower_enemy_dead.png")
		add_child(expl)
		$Death_Timer.start()

func _on_HurtArea_body_entered(body):
	if body.is_in_group("player"):
		"yellow flower hurt"
		body.hurt(1)
		
func _on_Death_Timer_timeout():
	queue_free()
