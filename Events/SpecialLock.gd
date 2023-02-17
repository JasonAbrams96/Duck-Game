extends StaticBody2D

var player_detected = false
var score = 1000
export var num = 0

func _ready():
	pass

func _process(delta):
	if player_detected:
		if Input.is_action_just_pressed("Quack") and Global.unlock_lock(num):
			if Global.locks.size() == 1:
				Global.create_sfx_audio("res://Assets/Audio/Last_Lock_unlocked.wav", get_tree().current_scene)
			else:
				Global.locks.erase(num)
				Global.create_sfx_audio("res://Assets/Audio/Special_Lock_placementr.wav", get_tree().current_scene)
			$Sprite.frame = 0
			PlayerGlobal.add_score(score)
			set_process(false)


func _on_Area2D_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("phead"):
		player_detected = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player") or body.is_in_group("phead"):
		player_detected = false
