extends Node2D

#export(Array, Vector2) var points

const IDLE_DURATION = 1.0
export var move_to = Vector2.RIGHT * 192
export var speed = 3.0

var follow = Vector2.ZERO

onready var platform = $Platform
onready var move_tween = $Tween


func _ready():
	_init_tween()
	
func _init_tween():
	var dur = move_to.length() / float(speed * 64)
	move_tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, dur, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	move_tween.interpolate_property(self, "follow", move_to, Vector2.ZERO, dur, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, dur + IDLE_DURATION * 2)
	move_tween.start()
	
func _physics_process(delta):
	platform.position = platform.position.linear_interpolate(follow, 0.075)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.on_moving_platform = true
		print("moving platform entered")


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		body.on_moving_platform = false
		print("moving platform exited")
