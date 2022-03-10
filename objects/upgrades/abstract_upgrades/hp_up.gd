extends Upgrade


func _ready():
	_up_name = ""
	_desc_name = ""
	_bonus_lv10_descr = " "
	_bonus_lv20_descr = " "
	_bonus_lv30_descr = " "
	_signal_connect = ""


func _execute():
	hero.bonus_hp += _bonus_level


func _unexecute():
	pass


func update_atribute_bonus():
	_atribute_bonus += next_bonus()
	hero.bonus_hp = next_bonus()
	

func check_next_atribute():
	return _atribute_bonus + next_bonus()
	

func next_bonus():
	return int(round(((pow(level, 1.5)+level*1.4)/7)+3))
	
	
