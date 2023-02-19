extends StaticBody2D


func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and ToxicWaterSingleton.player_detected != true:
		ToxicWaterSingleton.player_detected = true
		ToxicWaterSingleton.set_process(true)


func _on_Area2D_body_exited(body):
	if ToxicWaterSingleton.player_detected == true and body.motion.y < 0:
		ToxicWaterSingleton.timer.stop()
		ToxicWaterSingleton.player_detected = false
