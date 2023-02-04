extends Area2D

export var diff: float = 150.0
export var is_green = false

var modifier = ""
var dir = 1
var speed  = 150
var stop_dir = 1
var stop_count = 0
var max_stop_count = 60
var is_flipped = false

var points = 150

onready var start_pos = global_position

func _ready():
	if is_green:
		points *= 1.25
		speed *= 1.25
		modifier = "g_"
		
		
func _flip():
	is_flipped = !is_flipped
	dir *= -1
	$Sprite.flip_v = !$Sprite.flip_v
	

func _physics_process(delta):
	global_position.y -= speed * delta * dir * stop_dir
	
	if global_position.y < start_pos.y - diff:
		if stop_count != max_stop_count:
			$Sprite.play(modifier + "bite")
			stop_count += 1
			stop_dir = 0
			
		else:
			stop_count = 0
			$Sprite.play(modifier + "default")
			stop_dir = 1
			_flip()
			
	elif global_position.y > start_pos.y:
		_flip()


func _on_Fish_Enemy_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(1)


func _on_HItArea_body_entered(body):
	if body.is_in_group("player_head") and !is_flipped:
		var explosion = Global.explosion_particles.instance()
		explosion.my_texture = load("res://Assets/" + modifier + "fish_enemy.png")
		owner.add_child(explosion)
		explosion.global_position = self.global_position
		queue_free()
		
