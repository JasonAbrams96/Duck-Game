extends Control

onready var _grow_tween = $Tween
onready var _slide_show_tween = $Tween2

var grow_tween_on = true
var can_animate_slide_show = true
var slide_show_timer = [3.0, 2.5]
var popup_opened_once = false
func _ready():
	Global.change_bg_music(5)
	Global.read_scores()
	$ColorRect/HighScoreLbl.text += Global.high_score_name + " %016d" % Global.high_score
func _process(delta):
	
	if grow_tween_on:
		animate_grow_tween()
		
	if can_animate_slide_show:
		animate_slide_show()
	
	
#Tween animation for the slide show
func animate_slide_show():
	can_animate_slide_show = false
	yield(get_tree().create_timer(1.0), "timeout")
	_slide_show_tween.interpolate_property($ColorRect/Slide_show, "rect_position", Vector2(0.0, 0.0), Vector2(-336.0, 0.0), slide_show_timer[0], Tween.TRANS_ELASTIC)
	_slide_show_tween.start()
	yield(_slide_show_tween, "tween_completed")
	yield(get_tree().create_timer(2.0), "timeout")
	_slide_show_tween.interpolate_property($ColorRect/Slide_show, "rect_position", Vector2(-336, 0.0), Vector2(-672, 0.0), slide_show_timer[0], Tween.TRANS_ELASTIC)
	_slide_show_tween.start()
	yield(_slide_show_tween, "tween_completed")
	yield(get_tree().create_timer(2.0), "timeout")
	_slide_show_tween.interpolate_property($ColorRect/Slide_show, "rect_position", Vector2(-672.0, 0.0), Vector2(-1008.0, 0.0), slide_show_timer[0], Tween.TRANS_ELASTIC)
	_slide_show_tween.start()
	yield(_slide_show_tween, "tween_completed")
	yield(get_tree().create_timer(2.0), "timeout")
	_slide_show_tween.interpolate_property($ColorRect/Slide_show, "rect_position", Vector2(-1008.0, 0.0), Vector2(-1344.0, 0.0), slide_show_timer[0], Tween.TRANS_ELASTIC)
	_slide_show_tween.start()
	yield(_slide_show_tween, "tween_completed")
	yield(get_tree().create_timer(2.0), "timeout")
	_slide_show_tween.interpolate_property($ColorRect/Slide_show, "rect_position", Vector2(-1344.0, 0.0), Vector2(-1680.0, 0.0), slide_show_timer[0], Tween.TRANS_ELASTIC)
	_slide_show_tween.start()
	yield(_slide_show_tween, "tween_completed")
	yield(get_tree().create_timer(1.0), "timeout")

	$ColorRect/Slide_show.rect_position = Vector2(0.0, 0.0)
	can_animate_slide_show = true
	
	
#	Tween to animate teh growing of the title
func animate_grow_tween():
	grow_tween_on = false
	_grow_tween.interpolate_property($ColorRect/TitleRect, "rect_scale", Vector2(1.0, 1.0), Vector2(0.25, 0.25), 2.0, Tween.TRANS_SINE)
	_grow_tween.start()
	yield(_grow_tween, "tween_completed")
	_grow_tween.interpolate_property($ColorRect/TitleRect, "rect_scale", Vector2(0.25, 0.25), Vector2(1.0, 1.0), 2.0, Tween.TRANS_SINE)
	_grow_tween.start()
	yield(_grow_tween, "tween_completed")
	grow_tween_on = true
	
# Function that plays an audio effect when mouse enters
func _on_btn_mouse_entered():
	Global.create_sfx_audio("res://Assets/Audio/sfx_menu_move4.wav", self)


func _on_PlayBtn_pressed():
	if !popup_opened_once:
		popup_opened_once = true
		$EnterNameControl/PopupDialog.popup()
	else:
		Global.change_bg_music(4)
		GlobalTransition.is_death_transition = true
		get_tree().change_scene_to(GlobalTransition.transition)


func _on_QuitBtn_pressed():
	get_tree().quit()


func _on_SettingsBtn_pressed():
	Global.menus.append("res://Menu/Main Menu.tscn")
	get_tree().change_scene("res://Menu/Settings Menu.tscn")


func _on_mouse_entered():
	Global.create_sfx_audio("res://Assets/Audio/sfx_menu_move4.wav", get_tree().current_scene)
