extends StaticBody2D

var player_detected = false

#TODO Process for if player quacks


func _on_Area2D_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("phead"):
		player_detected = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player") or body.is_in_group("phead"):
		player_detected = false
