extends Area2D

var score = 100
var amount = 1


func _on_Hat_body_entered(body):
	if body.is_in_group("player"):
		Global.create_sfx_audio("res://Assets/Audio/sfx_sounds_powerup11.wav", owner)
		body.collect(name, amount, score)
		queue_free()
