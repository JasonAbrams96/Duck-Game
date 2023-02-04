extends KinematicBody2D

var can_move = false

var player = null
var velocity = Vector2()
var speed = 100
var dir = -1
var start_pos
var max_x = 64
var max_y = 33
var dir_y = 1

var player_detected = false

func _ready():
	start_pos = global_position
	
func _physics_process(delta):
	if can_move:
		if !player_detected:
			find_velocity()
			velocity = move_and_slide(velocity)

			if global_position.x < start_pos.x - max_x or global_position.x > start_pos.x + max_x:
				dir *= -1
				$Sprite.flip_h = !$Sprite.flip_h	
			if global_position.y < start_pos.y - max_y or global_position.y > start_pos.y + max_y:
				dir_y *= -1
			
		
func find_velocity():
	velocity.x = speed * dir
	
	velocity.y = 100 * dir_y
	
func _on_HitArea_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(1)

func _on_VisibilityNotifier2D_screen_entered():
	can_move = true
