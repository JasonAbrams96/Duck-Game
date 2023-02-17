extends Node

#loads
var audio_player = preload("res://Audio/SEAudioPlayer.tscn")
var music_player = null
var explosion_particles = preload("res://Particles/Explosion.tscn")
var cannon_ball = preload("res://Enemy/cannon_ball.tscn")
var brick_hit = preload("res://Assets/brick_opened.png")
var empty_heart = preload("res://Assets/heart_container_empty.png")
var full_heart = preload("res://Assets/heart_container.png")
var special = preload("res://Collectibles/Special.tscn")

var fire_fly = preload("res://Enemy/FireFly.tscn")
var falling_rock = preload("res://Enemy/FallingRock.tscn")

var pause_menu = preload("res://Menu/Pause.tscn")
#Globally Used by multiple things
var GRAVITY = 20
var bg_music = {
	1: "res://Assets/Audio/8 Bit Surf.ogg",
	2: "res://Assets/Audio/8 Bit Adventure.ogg",
	3: "res://Assets/Audio/A Bit of Hope.ogg"
}

#Transition Screen
var to_next_level = false
var world = 1
var level = 1
var current_level = "world" + String(world) + "-" + String(level)

#Special locks
var special_lock_1 = false
var special_lock_2 = false
var special_lock_3 = false

var special_1 = false
var special_2 = false
var special_3 = false


#Pages
var menus = []

func get_next_level():
	level += 1
	if level > 3:
		world += 1
		level = 1
	
	current_level = "world" + String(world) + "-" + String(level)
	return current_level
	
	
func get_next_level_string():
	var temp_level = level + 1
	var temp_world = world
	
	if temp_level > 3:
		temp_level = 1
		temp_world += 1
		
	return "world" +  String(temp_world) + " - " + String(temp_level)
	
func get_current_level():
	return current_level
	
func get_current_level_string():
	return "World " + String(world) + " - " + String(level)

func create_bg_audio():
	if music_player == null:
		music_player = load("res://Audio/BackgroundAudio.tscn").instance()
		get_tree().current_scene.add_child(music_player)
		
func change_bg_music(num):
	music_player.play_sound(bg_music.get(num))

func create_audio(audio, node_to_add_to: Node):
	var sound_player = audio_player.instance()
	
	if node_to_add_to  == null:
		add_child(sound_player)
	else:
		node_to_add_to.add_child(sound_player)
	sound_player.play_sound(audio)

func create_sfx_audio(audio, node_to_add_to: Node):
	var sound_player = audio_player.instance()
	
	sound_player.bus = "Sound effects"
	
	if node_to_add_to == null:
		add_child(sound_player)
	else:
		node_to_add_to.add_child(sound_player)
	sound_player.play_sound(audio)

func unlock_lock(num: int):
	if num == 1 and special_1:
		special_lock_1 = true
		return true
	elif num == 2 and special_2:
		special_lock_2 = true
		return true
	elif num == 3 and special_3:
		special_lock_3 = true
		return true
	return false
		
		
func lock_special(num: int):
	if num == 1:
		special_1 = true
	elif num == 2:
		special_2 = true
	elif num == 3:
		special_3 = true	
		
		
func all_locks_unlocked():
	if special_lock_1 == special_lock_2 and special_lock_2 == special_lock_3 and special_lock_3 == true:
		return true
	return false
	
func game_over():
	#resets the items for GLOBAL
	to_next_level = false
	world = 1
	level = 1
	current_level = "world" + String(world) + "-" + String(level)

	special_lock_1 = false
	special_lock_2 = false
	special_lock_3 = false

	special_1 = false
	special_2 = false
	special_3 = false
	
	#Calls other Singletons to game_over them
	GlobalTransition.game_over()
	PlayerGlobal.game_over()
	
	var transition = GlobalTransition.transition.instance()
