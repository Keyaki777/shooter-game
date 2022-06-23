extends Upgrade

var effect_state: bool = false


func _ready():
	_up_name = "Agressive Endurance"
	_up_effect = "Take 10% less damage while shooting"
	_scene_path = "res://objects/status/status.tscn"


func _execute(value = 0):
	pass


func _unexecute():
	pass


func _initialize() -> void:
	pass


func on_buy_effect():
	pass


func _execute_bonus_1() -> void:
	pass


func _execute_bonus_2() -> void:
	pass


func _execute_bonus_3() -> void:
	pass

func _on_timeout() -> void:
	_unexecute()
