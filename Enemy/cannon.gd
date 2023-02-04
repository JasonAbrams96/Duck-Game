extends StaticBody2D

class_name Cannon
export var cannon_ball_speed: int = 200
export var timeout: float = 1.5
onready var timer = $Timer

var can_fire_cannon = false

func _ready():
	$Timer.wait_time = timeout
	
func fire():
	var ball = Global.cannon_ball.instance()
	ball.global_position = $Position2D.global_position
	ball.speed = cannon_ball_speed
	owner.add_child(ball)
	
func _on_Timer_timeout():
	fire()


func _on_VisibilityNotifier2D_viewport_entered(viewport):
	can_fire_cannon = true
	timer.start()


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	can_fire_cannon = false
	timer.stop()


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		timer.stop()
		


func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		timer.start()
