extends Node2D

export var segments = 1

var height = 96
var diff = 90
var start_pos
var can_animate = false
var animating = false
func _ready():
	start_pos = global_position.y
	if segments > 1:
		for i in range(segments - 1):
			var copy = $Neck/AnimatedSprite.duplicate()
			$Neck.add_child(copy)
			copy.position.y += height * (i + 1)
			var area = copy.get_child(copy.get_child_count() - 1)
			area.connect("body_entered", area, "_on_Area_body_entered")


func _process(delta):
	if can_animate and !animating:
		animating = true
		$Tween.interpolate_property(self, "global_position:y",start_pos, start_pos - diff * segments, 1.5 + (segments / 2), Tween.TRANS_SINE)
		$Tween.start()
		yield($Tween, "tween_completed")
		yield(get_tree().create_timer(1.0), "timeout")
		$Tween.interpolate_property(self, "global_position:y",  start_pos - diff * segments, start_pos, 1.0 + (segments / 2), Tween.TRANS_SINE)
		$Tween.start()
		yield($Tween, "tween_completed")
		yield(get_tree().create_timer(1.0), "timeout")
		animating = false


func _on_VisibilityNotifier2D_screen_entered():
	can_animate = true


func _on_VisibilityNotifier2D_screen_exited():
	can_animate = false


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		body.hurt(1)
