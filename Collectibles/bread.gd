extends Node

var amount = 1
var score = 100

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.collect("Bread", amount, score)
		Global.create_sfx_audio("res://Assets/Audio/bread_collect.wav", owner)
		queue_free()
