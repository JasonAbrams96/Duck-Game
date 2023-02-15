extends Node

var player_in_lava = false

func _process(delta):
	if player_in_lava:
		player_in_lava = false
		#	5 is a OHKO number
		PlayerGlobal.player.hurt(5)

