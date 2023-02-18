extends Control




func _on_Button_pressed():
	 
	if $PopupDialog/Control.text != "":
		var text = $PopupDialog/Control.text.to_upper()
		var is_good = true
		
		for i in range(text):
			var c = text[i]
			if c.to_ascii() < 65 or c.to_ascii() > 90:
				is_good = false
				break
		
		if is_good:
			PlayerGlobal.my_name = $PopupDialog/Control.text
			$PopupDialog.visible = false
		


func _on_PopupDialog_about_to_show():
	$PopupDialog/Control.text = PlayerGlobal.my_name
