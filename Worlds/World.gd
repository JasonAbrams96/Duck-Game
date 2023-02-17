extends Node

signal countdown_timer(time)

onready var goal = $Goal
onready var player = $Player
onready var timer_til_next_level = Timer.new()

onready var countdown_timer = Timer.new()
export var countdown_time = 200

func _ready():
	Global.current_level = name
	$Goal.connect("goal_got", self, "player_got_in_goal")
	timer_til_next_level.wait_time = 3.0
	timer_til_next_level.connect("timeout", self, "_on_Timer_timeout")
	add_child(timer_til_next_level)
	
	countdown_timer.wait_time = 1.0
	countdown_timer.connect("timeout", self, "countdown_timer_timeout")
	
	#add the music player:
	Global.create_bg_audio()
	Global.change_bg_music(Global.world + 2)

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		var puase = Global.pause_menu.instance()
		add_child(puase)
		player.is_paused = true
		get_tree().paused = true

func _on_Timer_timeout():

	if Global.all_locks_unlocked() and Global.current_level == "world3-3":
		print("Special world unlocked TODO")
	else:
		get_tree().change_scene_to(GlobalTransition.transition)
	
func player_got_in_goal():
	GlobalTransition.is_death_transition = false
	timer_til_next_level.start()

func countdown_timer_timeout():
	countdown_time -= 1
	emit_signal("countdown_timer", countdown_time)
	
	if countdown_time == 0:
		print("player ran out of time")
		GlobalTransition.is_death_transition = true
		get_tree().change_scene("res://Events/Transition_Screen.tscn")
