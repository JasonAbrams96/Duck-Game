extends KinematicBody2D


var player_pos
var start_pos
var end_pos = Vector2()

var motion = Vector2()
var speed = 300

func _ready():
	player_pos = PlayerGlobal.player.global_position
	start_pos = global_position
	
	end_pos = Vector2(player_pos.x, player_pos.y - 10)
	#TODO make firefly fly down first then turn and go towards player
	#TODO explode when near end point.
	#TODO drop firerock near the player
func _physics_process(delta):
	
	motion = (end_pos - global_position).normalized()
	move_and_slide(motion * speed)
