extends CPUParticles2D



func _on_VisibilityNotifier2D_screen_entered():
	emitting = true


func _on_VisibilityNotifier2D_screen_exited():
	emitting = false
