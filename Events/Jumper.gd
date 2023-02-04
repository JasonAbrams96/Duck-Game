extends Area2D

var _player_detected = false


func _on_Jumper_body_entered(body):
	if body.is_in_group("player") and !_player_detected:
		body.jump(2)
		_player_detected = true
		$AnimationPlayer.play("Activated")
		$Timer.start()
		


func _on_Timer_timeout():
	_player_detected = false
