extends StaticBody2D


var has_item = true
#

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		pass
