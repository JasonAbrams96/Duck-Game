extends Control


func _ready():
	$master_volume.value = AudioServer.get_bus_volume_db(0)
	$sfx_volume.value = AudioServer.get_bus_volume_db(1)
	$music_volume.value = AudioServer.get_bus_volume_db(2)


func _on_music_volume_value_changed(value):
	if value == -60.0:
		set_0_audio(2)
	else:
		AudioServer.set_bus_volume_db(2, value)


func _on_sfx_volume_value_changed(value):
	if value == -60.0:
		set_0_audio(1)
	else:
		AudioServer.set_bus_volume_db(1, value)

func _on_master_volume_value_changed(value):
	if value == -60.0:
		set_0_audio(0)
	else:
		AudioServer.set_bus_volume_db(0, value)

func set_0_audio(bus):
	AudioServer.set_bus_volume_db(bus, -80)


#Function to go back from where player entered settings
func _on_BackBtn_pressed():
	Global.create_sfx_audio("res://Assets/Audio/sfx_menu_select5.wav", get_tree().current_scene)
	get_tree().change_scene(Global.menus.pop_back())


func _on_slider_bar_mouse_entered():
	Global.create_sfx_audio("res://Assets/Audio/sfx_menu_select5.wav", self)


func _on_BackBtn_mouse_entered():
	Global.create_sfx_audio("res://Assets/Audio/sfx_menu_move4.wav", get_tree().current_scene)
