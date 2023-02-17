extends AudioStreamPlayer

var offset = 0
var current_song = ""

func replay():
	play(offset)
	
func _ready():
	
	connect("finished", self, "replay")
	
func play_sound(sound_file):

	if sound_file != current_song:
		if sound_file is String:
			current_song = sound_file
			var sound = load(sound_file)
			set_stream(sound)
		elif sound_file is AudioStream:
			set_stream(sound_file)
			
		if playing:
			stop()
		play(offset)

