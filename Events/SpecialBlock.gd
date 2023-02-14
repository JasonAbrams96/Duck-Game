extends StaticBody2D

var opened = false
var item = preload("res://Collectibles/Special.tscn")

export var num = 0

func _ready():
	if num == 1 and Global.special_1 == true: open()
	elif num == 2 and Global.special_2 == true: open()
	elif num == 3 and Global.special_3 == true: open()
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("p_head") and !opened:
		opened = true
		$Sprite.texture = load("res://Assets/mystery_box_opened.png")
		item = item.instance()
		item.num = num
		item.global_position = $Position2D.global_position
		owner.add_child(item)

func open():
	opened = true
	$Sprite.texture = load("res://Assets/mystery_box_opened.png")
	item = null
