extends Upgrade

func _ready():
	_up_name = "On Enemy Died"
	_desc_name = "triggers when enemy die"
	_bonus_lv10_descr = ""
	_bonus_lv20_descr = ""
	_bonus_lv30_descr = ""
	_signal_connect = "hero_shield_full"
	_signal_bonus10 = "enemy_died"
	_signal_bonus20 = ""
	_signal_bonus30 = ""
	_scene_path = "res://objects/status/status.tscn"
	

func _execute(value = 0):
	self.add_status_on_hero_weapon()
	print(name)


func _unexecute():
	pass


func _initialize() -> void:
	pass


func update_atribute_bonus():
	_atribute_bonus += next_bonus()
	hero.bonus_hp = next_bonus()
	print("next_bonus = ", next_bonus())
	pass
	

func check_next_atribute():
	return _atribute_bonus + next_bonus()


func next_bonus():
	return int(round(((pow(level, 1.5)+level*1.4)/7)+3))
	
	
func on_signal_received(value = 0):
	_execute()


func _execute_bonus_10() -> void:
	print("enemy died and bonus 10 executed")


func _execute_bonus_20() -> void:
	pass


func _execute_bonus_30() -> void:
	pass