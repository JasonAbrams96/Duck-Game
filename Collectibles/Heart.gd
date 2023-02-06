extends Area2D

var amount = 1
var score = 200
var n = "HEART"



func _on_Heart_body_entered(body):
	if body.is_in_group("player"):
		body.collect(n, amount, score)
		queue_free()
