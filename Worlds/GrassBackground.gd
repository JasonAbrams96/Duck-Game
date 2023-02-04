extends ParallaxBackground

var clouds_x_offset = -15

func _process(delta):
	$ParallaxLayer4.motion_offset.x += clouds_x_offset * delta
