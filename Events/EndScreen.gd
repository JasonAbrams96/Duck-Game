extends Control


var secret_level_found = true
var is_playing = false

func _ready():
	$Labels/Label5/HighScoreLbl.text = "Your Score: %016d" % Global.high_score
	if secret_level_found:
		$Labels/Label5.text = "Fin.\nCongratulations on finding the easter\negg to my next game!"
	Global.change_bg_to_nothing()
	Global.update_score()
	
func _process(delta):
	if !is_playing:
		is_playing = true
		$Tween.interpolate_property($Labels, "rect_position", Vector2(304.0, 350.0), Vector2(304.0, -2120.0), 30.0, Tween.TRANS_LINEAR)
		$Tween.start()
		yield($Tween, "tween_completed")
		set_process(false)
		

func _on_TextureButton_pressed():
	GlobalTransition.completed_game = false
	get_tree().change_scene("res://Menu/Main Menu.tscn")
