extends Node
class_name Upgrade

signal request_signal_connect(upgrade)

var hero: Hero

export var _up_name: String = ""
export var _desc_name: String = ""
export var _bonus_level: float = 1.0

var _atribute_bonus: float = 0

export var _bonus_lv10_descr: String = " "
export var _bonus_lv20_descr: String = " "
export var _bonus_lv30_descr: String = " "
export var _signal_connect: String = " "


#var category: = 

var price: int setget set_price, get_price
var level: = 1

# if is already selected to be shown to the player on ui
export var is_selected: bool = false
# if the upgrade have already been bought by the player
export var is_activated: bool = false
# if the upgrade has be unlocked by the player
export var is_unlocked: bool = false
export var is_signal_connect: bool = false

var is_bonus_10: bool = false
var is_bonus_20: bool = false
var is_bonus_30: bool = false


func initialize() -> void:
	if !is_signal_connect:
		return
	emit_signal("request_signal_connect", self)
	is_activated = true


func execute() -> void:
	_execute()
	
	
func unexecute() -> void:
	_unexecute()


func _execute() ->void:
	pass


func _unexecute() -> void:
	pass


func get_price():
	price = round( pow(level, 2) + level * 3 + 10)
	return price


func set_price(value) -> void:
	pass


func buy() -> void:
	if !is_activated:
		initialize()
	level += 1
	check_bonus()
	update_atribute_bonus()
	
	
func update_atribute_bonus() -> void:
	pass


func check_next_atribute():
	pass


func check_bonus() -> void:
	if !is_bonus_10 and level >= 10:
		execute_bonus_10()
		
	if !is_bonus_20 and level >= 20:
		execute_bonus_20()
		
	if !is_bonus_30 and level >= 30:
		execute_bonus_30()


func execute_bonus_10() -> void:
	is_bonus_10 = true

func execute_bonus_20() -> void:
	is_bonus_20 = true

func execute_bonus_30() -> void:
	is_bonus_30 = true
	

func on_signal_received(value):
	_execute()
	print("original")
