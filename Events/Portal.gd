tool
extends Area2D
class_name TeleportPortal

export(NodePath) var Opposite_Portal_Path = null

onready var spat_point = $Position2D

var Opposite_Portal

var timer #Timer to timeout for player interacting with portal

var bod = null
var bod_can_see = true

func _ready():
	assert(Opposite_Portal_Path, !null)
	Opposite_Portal = get_node(Opposite_Portal_Path)
	timer = Timer.new()         
	timer.wait_time = 1.0
	timer.connect("timeout", self, "timer_timeout")
	add_child(timer)

func _on_Yellow_Portal_body_entered(body):
	check(body)

func _on_Orange_Portal_body_entered(body):
	check(body)

func check(body):
	if body.is_in_group("player") and Opposite_Portal.bod_can_see:
		Opposite_Portal.bod_can_see = false
		self.bod = body
		if body.is_visible:
			body.toggle_vb_notifier()
			timer.start()
		
		body.global_position = Opposite_Portal.spat_point.global_position
		body.change_camera_location(Opposite_Portal.spat_point.global_position)
		
	elif  body.is_in_group("enemy"):
		body.global_position = Opposite_Portal.spat_point.global_position

func timer_timeout():
	bod_can_see = true
	bod.toggle_vb_notifier()
	timer.stop()
