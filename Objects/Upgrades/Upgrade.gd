extends Node
class_name Upgrade

signal request_signal_connect(upgrade)
signal request_signal_trigger10(upgrade)
signal request_signal_trigger20(upgrade)
signal request_signal_trigger30(upgrade)


enum Elemental_Type {NORMAL, POISON, FIRE, WATER, ICE, LIGHT}

enum Unique_Types{BASIC, SECONDARY_ELEMENTAL, SHOOT_ELEMENTAL, REVENGE, MISS, SHIELD_NOVA, CRITICAL, SHIELD_ON, SHIELD_ON}
export (Unique_Types) var unique_type = Unique_Types.BASIC

#enum Teams{PLAYER, ENEMY}
#export (Teams) var team := Teams.ENEMY

var hero: Hero

var _up_name: String = ""
var _desc_name: String = ""
export var _bonus_level: float = 1.0

var _atribute_bonus: float = 0

var _bonus_lv10_descr: String = ""
var _bonus_lv20_descr: String = ""
var _bonus_lv30_descr: String = ""
var _signal_connect: String = ""
var _scene_path: String = ""

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

var _signal_bonus10: String = ""
var _signal_bonus20: String = ""
var _signal_bonus30: String = ""


func initialize() -> void:
	if !is_signal_connect:
		return
	emit_signal("request_signal_connect", self)
	is_activated = true
	get_children()


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
	level += 15
	check_bonus()
	update_atribute_bonus()
	
	
func update_atribute_bonus() -> void:
	pass


func check_next_atribute():
	pass


func check_bonus() -> void:
	if !is_bonus_10 and level >= 10:
		init_bonus_10()
		
	if !is_bonus_20 and level >= 20:
		init_bonus_20()
		
	if !is_bonus_30 and level >= 30:
		init_bonus_30()


func _execute_bonus_10() -> void:
	pass


func _execute_bonus_20() -> void:
	pass


func _execute_bonus_30() -> void:
	pass
	

func on_signal_received(value = 0):
#	_execute()
	pass


func init_bonus_10() -> void:
	is_bonus_10 = true
	if _signal_bonus10 != "":
		emit_signal("request_signal_trigger10",self)


func init_bonus_20() -> void:
	is_bonus_20 = true
	if _signal_bonus20 != "":
		emit_signal("request_signal_trigger20",self)


func init_bonus_30() -> void:
	is_bonus_30 = true
	if _signal_bonus30 != "":
		emit_signal("request_signal_trigger30",self)


func add_status_on_hero_weapon() -> void:
	hero.hero_weapon.add_status(_scene_path)
