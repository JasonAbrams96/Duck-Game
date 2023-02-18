extends Node

signal score_updated(new_score)
signal health_updated(new_health)
signal bread_updated(new_amount)
signal lives_updated(new_lives)
signal dead
signal game_over

var score = 0
var num_of_jumps = 0
var rand
var health = 3
var bread = 0
var player
var num_of_lives = 4
var specials_collected = 0
var my_name = "NIL"

func _ready():
	rand = RandomNumberGenerator.new()
	rand.seed = 12231996
	
func get_i_rand_range_num(low, high):
	return rand.randi_range(low, high)
	
func get_f_rand_range_num(low, high):
	return rand.randf_range(low, high)
	
func add_bread(amount):
	bread += amount
	emit_signal("bread_updated", bread)
	
func add_score(s):
	score += s
	emit_signal("score_updated", score)
	
func add_health(amount):
	health += amount
	emit_signal("health_updated", health)
	
func add_special(amount):
	specials_collected += amount
	
func respawn():
	num_of_lives -= 1
	emit_signal("lives_updated", num_of_lives)
	health = 3
	emit_signal("health_update", health)
	
	if num_of_lives == 0:
		GlobalTransition.set_game_over()
		game_over()
	
	
func game_over():
	Global.update_score()
	Global.save_scores()
	
	score = 0
	num_of_jumps = 0
	health = 3
	bread = 0
	player = null
	num_of_lives = 3
	specials_collected = 0
	my_name = "NIL"
	
