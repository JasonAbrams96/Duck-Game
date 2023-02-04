extends CPUParticles2D

export var my_texture: Texture
func _ready():
	if texture != null:
		$".".texture = my_texture
	emitting = true
	
func _process(delta):
	if !emitting:
		queue_free()
		
