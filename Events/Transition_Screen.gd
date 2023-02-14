extends Control

onready var lives_label = $Sprite/Label
onready var next_level_lbl = $NextLevelLabel
onready var current_world_lbl = $NextLevelLabel/Label

func _ready():
	
	lives_label.text = "x  " + String(PlayerGlobal.num_of_lives)
	if GlobalTransition.is_death_transition:
		current_world_lbl.text = "CURRENT WORLD:  " + Global.get_current_level_string()
	elif GlobalTransition.is_game_over:
		current_world_lbl.text = "G A M E   O V E R"
		lives_label.text = "x 0"
		$Sprite.flip_h = true
		$Sprite.flip_v = true
	else:
		current_world_lbl.text = "CURRENT WORLD:  " + Global.get_next_level_string()
	
	next_level_lbl.text = ""

	$Timer.start()

func _on_Timer_timeout():
	if GlobalTransition.is_death_transition:
		get_tree().change_scene_to(load("res://Worlds/" + Global.get_current_level() + ".tscn"))
	elif GlobalTransition.is_game_over:
		get_tree().change_scene_to(load("res://Menu/Main Menu.tscn"))
	else:
		get_tree().change_scene_to(load("res://Worlds/" + Global.get_next_level() + ".tscn"))
