extends CanvasLayer


func _ready():
	$Control/SettingsPanel/MasterSlider.value = AudioServer.get_bus_volume_db(0)
	$Control/SettingsPanel/BGSlider.value = AudioServer.get_bus_volume_db(2)
	$Control/SettingsPanel/SFXSlider.value = AudioServer.get_bus_volume_db(1)
	
func _on_ResumeBtn_pressed():
	get_tree().paused = false
	PlayerGlobal.player.is_paused = false
	Global.create_sfx_audio("res://Assets/Audio/sfx_sounds_pause3_out.wav", get_tree().current_scene)
	queue_free()

func _on_QuitBtn_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Menu/Main Menu.tscn")

func _on_SettingsBtn_pressed():
	$Control/PausePanel.visible = false
	$Control/SettingsPanel.visible = true

func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)


func _on_TextureButton_pressed():
	$Control/SettingsPanel.visible = false
	$Control/PausePanel.visible = true


func _on_BGSlider_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)


func _on_SFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)


func _on_mouse_entered():
	Global.create_sfx_audio("res://Assets/Audio/sfx_menu_move4.wav", get_tree().current_scene)


func _on_slider_mouse_entered():
	Global.create_sfx_audio("res://Assets/Audio/sfx_menu_move4.wav", get_tree().current_scene)
