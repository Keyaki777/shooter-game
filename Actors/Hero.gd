extends Node2D
class_name Hero

export var speed: int = 0

export var base_hp: int = 1
var bonus_hp: int = 0 setget set_bonus_hp
var bonus_percent_hp: int = 0 setget set_bonus_percent_hp

#setget cuz i want everry time the hp is changed everything linked to it also changes eg.(hp bar or animations trigged)
var _max_hp: = 0

func _powered_up() -> void:
	pass

func set_max_hp() -> void:
	var percentage_of_total_hp = (bonus_hp + base_hp)/100 * bonus_percent_hp
	_max_hp = base_hp + bonus_hp + percentage_of_total_hp
	print(_max_hp)


func set_bonus_hp(value):
	bonus_hp = bonus_hp + value
	set_max_hp()
	
	
func set_bonus_percent_hp(value) -> void:
	bonus_percent_hp += value
	set_max_hp()
	
