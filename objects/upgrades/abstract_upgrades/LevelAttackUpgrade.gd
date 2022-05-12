extends Upgrade

func _ready():
	_up_name = "Poison Attack1"
	_up_effect = "trigg die"

#	_signal_connect = "hero_shield_full"

	_scene_path = "res://objects/status/status.tscn"
	

func _execute(value = 0):
	print(name)


func _unexecute():
	pass


func _initialize() -> void:
	pass


func on_buy_effect():
#	hero.set_bonus_hp(350)
#	add_status_on_hero_weapon("poison")
	pass

func on_buy_signal_connect() -> void:
	SignalManager.connect(level)


func on_signal_received(value = 0):
	_execute()


func _execute_bonus_1() -> void:
	print("enemy died and bonus 10 executed")


func _execute_bonus_2() -> void:
	pass


func _execute_bonus_3() -> void:
	pass
