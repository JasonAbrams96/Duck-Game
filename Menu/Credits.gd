extends Control



func _on_BackButton_pressed():
	Global.create_sfx_audio("res://Assets/Audio/sfx_menu_move4.wav", get_tree().current_scene)
	get_tree().change_scene(Global.menus.pop_back())
