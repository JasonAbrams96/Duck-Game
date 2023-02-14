extends Node


var is_death_transition = false
var is_game_over = false

var transition = load("res://Events/Transition_Screen.tscn")

func game_over():
	is_death_transition = false
	is_game_over = true
