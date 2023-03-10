extends StaticBody2D

var can_spawn = false
var spawn_max = 5


func _on_VisibilityNotifier2D_screen_entered():
	if spawn_max > 0:
		can_spawn = true
		$Timer.start()


func _on_VisibilityNotifier2D_screen_exited():
	can_spawn = false
	$Timer.stop()


func _on_Timer_timeout():
	if can_spawn and spawn_max > 0:
		var firefly = Global.fire_fly.instance()
		firefly.start_pos = $Position2D.global_position
		get_parent().add_child(firefly)
		spawn_max -= 1
		
	else:
		$Timer.stop()
		
		
