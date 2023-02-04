extends AudioStreamPlayer

var offset = 0

func delete_self():
	queue_free()
	
func _ready():
	connect("finished", self, "delete_self")
	
func play_sound(sound_file):

	if sound_file is String:
		var sound = load(sound_file)
		set_stream(sound)
	elif sound_file is AudioStream:
		set_stream(sound_file)
	play(offset)

