extends Node


var player_detected = false
var timer = Timer.new()
var timer_added = false

func _ready():
	timer.wait_time = 0.8
	timer.connect("timeout", self, "timer_timeout")
	
func _process(delta):
	if !timer_added and player_detected:
		get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1).add_child(timer)
		timer.start()
		set_process(false)
		
func timer_timeout():
	if !player_detected:
		timer.stop()
		get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 1).remove_child(timer)
		timer_added = false
	else:
		print("toxic water hurt")
		PlayerGlobal.player.hurt(1)
