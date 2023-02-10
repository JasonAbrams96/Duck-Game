extends KinematicBody2D


var player_pos
var start_pos
var end_pos = Vector2()

var motion = Vector2()
var speed = 100
var dir = 0

var moving_down = true
var moving_towards_player = false

func _ready():
	player_pos = PlayerGlobal.player.global_position
	
	if player_pos.x - global_position.x < 0 and dir == 0:
			dir = -1
	elif player_pos.x - global_position.x > 0 and dir == 0:
			dir = 1
func _process(delta):
	if global_position.x <= player_pos.x + 64:
		$AnimatedSprite.play("r_flying")
	else:
		$AnimatedSprite.play("flying")
	#TODO make firefly fly down first then turn and go towards player
	#TODO explode when near end point.
	#TODO drop firerock near the player
func _physics_process(delta):
	if moving_down:
		motion.y = speed
		if global_position.y > player_pos.y - 48 and !PlayerGlobal.player.in_jump or global_position.y > player_pos.y - 16 and PlayerGlobal.player.in_jump:
			moving_down = false
			moving_towards_player = true
			motion
	elif moving_towards_player:
		motion.x = speed * 1.5 * dir
		motion.y = 0
		
	player_pos = PlayerGlobal.player.global_position
	move_and_slide(motion)
