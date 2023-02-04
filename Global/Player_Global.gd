extends Node

signal score_updated(new_score)
signal health_updated(new_health)
signal bread_updated(new_amount)

var score = 0
var num_of_jumps = 0
var rand
var health = 3
var bread = 0
var player
var num_of_lives = 3

func _ready():
	rand = RandomNumberGenerator.new()
	rand.seed = 12231996
	
func get_i_rand_range_num(low, high):
	return rand.randi_range(low, high)
	
func add_bread(amount):
	bread += amount
	emit_signal("bread_updated", bread)
	
func add_score(s):
	score += s
	emit_signal("score_updated", score)
	
func add_health(amount):
	health += amount
	emit_signal("health_updated", health)
