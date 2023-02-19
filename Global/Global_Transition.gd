extends Node


var is_death_transition = false
var is_game_over = false
var completed_game = false
var current_world = 1

var transition = load("res://Events/Transition_Screen.tscn")
func _ready():
	PlayerGlobal.connect("game_over", self, "set_game_over")
	
func game_over():
	is_death_transition = false
	is_game_over = true

func set_game_over():
	is_death_transition = false
	is_game_over = true
