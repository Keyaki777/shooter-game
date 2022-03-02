extends Node

signal false_hit


var can_be_hited: bool = true
onready var upgrade = $upgrade

func _ready():
	upgrade.character = self


func false_hit() -> void:
		emit_signal("false_hit")
		if can_be_hited == false: print("false_hit ok")
		if can_be_hited == true: print("fail")
		
		can_be_hited = true

	
func true_hit():
	if can_be_hited == true: print("true hit ok")
	if can_be_hited == false: print("fail")


func _on_true_Timer_timeout():
	true_hit()


func _on_player_false_hit():
	can_be_hited = false


func _on_false_Timer_timeout():
	false_hit()
