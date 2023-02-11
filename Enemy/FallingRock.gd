extends KinematicBody2D

var motion = Vector2()

func _physics_process(delta):
	motion.y += Global.GRAVITY
	move_and_slide(motion)
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(1)
		queue_free()
	elif body.is_in_group("platform"):
		#Chance to change into an enemy 1% chance
		var rand_i = PlayerGlobal.get_i_rand_range_num(0, 99)
		if rand_i < 99:
			#explode
			var part = load("res://Particles/Explosion.tscn").instance()
			part.my_texture = load("res://Assets/fireball_frame_1.png")
			get_parent().add_child(part)
			part.global_position = global_position
		else:
			var rand_e = PlayerGlobal.get_i_rand_range_num(0, 99)
			if rand_e <= 99:
				var enemy = load("res://Enemy/Rock Enemy.tscn").instance()
				enemy.is_magama = true
				get_parent().add_child(enemy)
				enemy.global_position = global_position
		
		queue_free()
