extends KinematicBody2D

var speed = 50
var motion = Vector2()
var dir = 1
var dead = false

var points = 200


func _process(delta):
	if global_position.y > 450:
		queue_free()
		
func _physics_process(delta):
	#Find direction
	if is_on_wall():
		dir *= -1
		scale.x *= -1
	motion.x = speed * dir
	
	if !is_on_floor():
		motion.y += Global.GRAVITY
	else: 
		motion.y = 0
		
	motion = move_and_slide(motion, Vector2.UP)
		

func _on_hurt_area_body_entered(body):
	if body.is_in_group("player") and not dead:
		print("red flower hurt")
		body.hurt(1)
		

func _on_JumpArea_body_entered(body):
	if body.is_in_group("player"):
		body.jump(1)
		dead = true
		set_collision_mask_bit(0, 0)
		$HurtArea1.monitoring = false
		$HurtArea2.monitoring = false
		$JumpArea.monitoring = false
		$AnimatedSprite.play("dead")
		set_physics_process(false)
		PlayerGlobal.score += points
		PlayerGlobal.emit_signal("score_updated", PlayerGlobal.score)
		var expl = Global.explosion_particles.instance()
		expl.my_texture = load("res://Assets/r_flower_enemy_dead-export.png")
		add_child(expl)
		$DeathTimer.start()

func _on_DeathTimer_timeout():
	queue_free()
