extends Upgrade


func _ready():
	_up_name = "HP UP"
	_up_effect = "Raises your HP from 100 to 150"
	_bonus_1 = ""
	_bonus_2 = ""
	_bonus_3 = ""
#	_signal_connect = "hero_shield_full"
	_signal_bonus1 = "enemy_died"
	_signal_bonus2 = ""
	_signal_bonus3 = ""
	_scene_path = "res://objects/status/status.tscn"


func _execute(value = 0):
	print(name)


func _unexecute():
	pass


func _initialize() -> void:
	pass


func on_buy_effect():
	print(hero._hp)
	hero.set_bonus_hp(50)
	print(hero._hp)


func on_signal_received(value = 0):
	_execute()


func _execute_bonus_1() -> void:
	pass

func _execute_bonus_2() -> void:
	pass


func _execute_bonus_3() -> void:
	pass
