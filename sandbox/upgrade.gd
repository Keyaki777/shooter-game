extends Node

var character


func is_miss():
	character.can_be_hited = false


func _on_player_false_hit():
	is_miss()
