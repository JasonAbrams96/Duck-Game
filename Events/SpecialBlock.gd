extends StaticBody2D

var opened = false
var item = preload("res://Collectibles/Special.tscn")



func _on_Area2D_body_entered(body):
	if body.is_in_group("p_head"):
		$Sprite.texture = load("res://Assets/mystery_box_opened.png")
		item = item.instance()
		item.global_position = $Position2D.global_position
		owner.add_child(item)

		
