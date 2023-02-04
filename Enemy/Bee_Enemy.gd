extends KinematicBody2D


var player = null
var player_detected = false
var back_home_pos = true

onready var start_pos = global_position

var velocity = Vector2()
var direction_x = 1

var speed = 100
var difference = 96.0

func _physics_process(delta):
	
	if !player_detected and back_home_pos:
		
		if start_pos.x - global_position.x < -difference or start_pos.x - global_position.x > 96.0:
			direction_x *= -1
			if direction_x == -1:
				$Sprite.flip_h = true
			elif direction_x == 1:
				$Sprite.flip_h = false
			
		velocity.x = direction_x * speed
		move_and_slide(velocity)
		
	elif player_detected and !player.in_goal:
		var vector = (player.global_position - global_position).normalized()
		#	chagnes direction of sprite
		if vector.x <= 0.0:
			$Sprite.flip_h = true
		elif vector.x > 0.0:
			$Sprite.flip_h = false
		move_and_slide(vector * speed)
		
	elif !back_home_pos:
		var vector = (start_pos - global_position).normalized()
		#	chagnes direction of sprite
		if vector.x <= 0.0:
			$Sprite.flip_h = true
		elif vector.x > 0.0:
			$Sprite.flip_h = false
		move_and_slide(vector * speed)
		
		if global_position.x > start_pos.x - 4.0 and global_position.x < start_pos.x + 4.0:
			back_home_pos = true
		 
	
func _on_HitArea_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(1)
		
func _on_DetectionArea_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_detected = true
		back_home_pos = false

func _on_DetectionArea_body_exited(body):
	if body.is_in_group("player"):
		player = null
		player_detected = false
