extends KinematicBody2D

var player = null



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player = body


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player = null
