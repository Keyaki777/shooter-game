extends Upgrade

func _ready():
	_up_name = "Shield Steal"
	_up_effect = "When you kill an enemy you recover 30 shield"
	_bonus_1 = ""
	_bonus_2 = ""
	_bonus_3 = ""
	_signal_connect = "enemy_died"
	_signal_bonus1 = ""
	_signal_bonus2 = ""
	_signal_bonus3 = ""
	_scene_path = "res://objects/status/status.tscn"
	

func _execute():
	hero.shield_recharge_action.recover_shield(50)


func _unexecute():
	pass


func _initialize() -> void:
	pass


func on_buy_effect():
	hero.hero_weapon.max_enemies_bounces += 1


func on_signal_received(value = 0):
	_execute()


func _execute_bonus_1() -> void:
	print("enemy died and bonus 10 executed")


func _execute_bonus_2() -> void:
	pass


func _execute_bonus_3() -> void:
	pass
