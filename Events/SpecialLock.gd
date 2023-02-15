extends StaticBody2D

var player_detected = false
export var num = 0

func _ready():
	pass

func _process(delta):
	if player_detected:
		if Input.is_action_just_pressed("Quack") and Global.unlock_lock(num):
			$Sprite.frame = 0
			set_process(false)


func _on_Area2D_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("phead"):
		player_detected = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player") or body.is_in_group("phead"):
		player_detected = false
