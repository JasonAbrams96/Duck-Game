extends StaticBody2D

export var can_open = true
export var has_item = true
export var collectible: PackedScene = null

func _on_Area2D_body_entered(body):
	if body.is_in_group("p_head") and can_open and body.get_parent().motion.y < 0.0:
		open()
		
		
func open():
	Global.create_sfx_audio("res://Assets/Audio/sfx_movement_footsteps1a.wav", self)
	$Sprite.texture = Global.brick_hit
	if has_item:
		$Sprite.visible = true
		if collectible == null:
			var b  = Global.bread_scene.instance()
			owner.call_deferred("add_child", b)
			b.global_position = $Position2D.global_position
		else:
			var c = collectible.instance()
			owner.call_deferred("add_child", c)
			c.global_position = $Position2D.global_position
	$Area2D.queue_free()

