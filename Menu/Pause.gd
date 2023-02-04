extends CanvasLayer


func _ready():
	$Control/SettingsPanel/MasterSlider.value = AudioServer.get_bus_volume_db(0)
	
func _on_ResumeBtn_pressed():
	$Control.visible = false
	pause_mode = false

func _on_QuitBtn_pressed():
	pause_mode = false
	get_tree().change_scene("res://Menu/Main Menu.tscn")

func _on_SettingsBtn_pressed():
	$Control/PausePanel.visible = false
	$Control/SettingsPanel.visible = true

func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)


func _on_TextureButton_pressed():
	$Control/SettingsPanel.visible = false
	$Control/PausePanel.visible = true
