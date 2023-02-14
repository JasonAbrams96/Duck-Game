extends Node

var player_in_lava = false

func _process(delta):
	if player_in_lava:
		player_in_lava = false
		PlayerGlobal.player.hurt(3)

