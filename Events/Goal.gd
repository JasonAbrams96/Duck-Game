extends StaticBody2D

var goal_already_got = false
signal goal_got

func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and not goal_already_got:
		PlayerGlobal.score += 1000
		goal_already_got = true
		body.in_goal = true
		var conf = load("res://Particles/Confetti.tscn").instance()
		emit_signal("goal_got")
		add_child(conf)
		conf.global_position = $Position2D.global_position
		conf.emitting = true
		Global.create_sfx_audio("res://Assets/Audio/sfx_sounds_fanfare3.wav", self)
		
		
		
