extends KinematicBody2D


var player_pos
var start_pos
var end_pos = Vector2()

var motion = Vector2()
var speed = 100
var dir = 0

var moving_down = true
var moving_towards_player = false
var can_drop = true

func _ready():
	if start_pos != null:
		global_position = start_pos
	
	player_pos = PlayerGlobal.player.global_position
	
	if player_pos.x - global_position.x < 0 and dir == 0:
			dir = -1
	elif player_pos.x - global_position.x > 0 and dir == 0:
			dir = 1
			$AnimatedSprite.flip_h = true

func _process(delta):
	if global_position.x <= player_pos.x + 64 and global_position.x >= player_pos.x - 64 and can_drop and !PlayerGlobal.player.in_goal:
		$AnimatedSprite.play("r_flying")
		if can_drop:
			var ins = Global.falling_rock.instance()
			get_parent().add_child(ins)
			ins.global_position = global_position
			can_drop = false
	elif can_drop:
		$AnimatedSprite.play("flying")

	
func _physics_process(delta):
	if moving_down:
		motion.y = speed * 1.5
		if global_position.y > player_pos.y - 48 and !PlayerGlobal.player.in_jump or global_position.y > player_pos.y - 16 and PlayerGlobal.player.in_jump:
			moving_down = false
			moving_towards_player = true
			motion
	elif moving_towards_player:
		motion.x = speed * 1.25 * dir
		motion.y = 0
		
	player_pos = PlayerGlobal.player.global_position
	move_and_slide(motion)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
