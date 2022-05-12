extends Upgrade

func _ready():
	_up_name = "LifeSteal"
	_up_effect = "Whenever You Kill An Enemy You Heal 1 HP"
	_bonus_1 = ""
	_bonus_2 = ""
	_bonus_3 = ""
#	_signal_connect = "hero_shield_full"
	_scene_path = "res://objects/status/status.tscn"
	

func _execute():
	print(name)
	hero.get_heal(1)


func _unexecute():
	pass


func _initialize() -> void:
	pass


func on_buy_effect():
	pass


func on_signal_received(value = 0):
	_execute()


func _execute_bonus_1() -> void:
	print("enemy died and bonus 10 executed")


func _execute_bonus_2() -> void:
	pass


func _execute_bonus_3() -> void:
	pass
