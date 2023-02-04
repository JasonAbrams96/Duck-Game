extends Area2D

func _on_Spikes_body_entered(body):
	if body.is_in_group("player_head") or body.is_in_group("player"):
		body.hurt(1)
