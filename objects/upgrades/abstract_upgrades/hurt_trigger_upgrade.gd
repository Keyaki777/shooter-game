extends Upgrade


func _execute(value = 0):
	print("executed hurt signal")


func _unexecute():
	pass


func _initialize() -> void:
	pass


func update_atribute_bonus():
	_atribute_bonus += next_bonus()
	hero.bonus_hp = next_bonus()
	print("next_bonus = ", next_bonus())
	

func check_next_atribute():
	return _atribute_bonus + next_bonus()


func next_bonus():
	return int(round(((pow(level, 1.5)+level*1.4)/7)+3))
	
	
func on_signal_received(value):
	print(value)
	.on_signal_received(value)
