extends Node
class_name Upgrade

signal unlock_secondary(secondary_type)
signal request_signal_connect(upgrade)
signal request_signal_trigger1(upgrade)
signal request_signal_trigger2(upgrade)
signal request_signal_trigger3(upgrade)


enum Types {Normal, Poison, Fire, Water, Ice}
export (Types) var type = Types.Normal

enum Unique_Types{Basic, AttackType, Revenge, Miss, ShieldNova, Critical, ShieldOn, EnemyKilled}
export (Unique_Types) var unique_type = Unique_Types.Basic

#enum Teams{PLAYER, ENEMY}
#export (Teams) var team := Teams.ENEMY

var hero: Hero

var _up_name: String = ""
var _up_effect: String = ""
export var _bonus_level: float = 1.0

var _atribute_bonus: float = 0

var _bonus_1: String = ""
var _bonus_2: String = ""
var _bonus_3: String = ""
var _signal_connect: String = ""
var _scene_path: String = ""

#var category: = 

var level: = 1

# if is already selected to be shown to the player on ui
export var is_selected: bool = false
# if the upgrade have already been bought by the player
export var is_activated: bool = false
# if the upgrade has be unlocked by the player
export var is_unlocked: bool = false
export var is_signal_connect: bool = false

var is_bonus_1: bool = false
var is_bonus_2: bool = false
var is_bonus_3: bool = false

var _signal_bonus1: String = ""
var _signal_bonus2: String = ""
var _signal_bonus3: String = ""


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



func buy() -> void:
	if !is_activated:
		initialize()
#	check_bonus()
#	update_atribute_bonus()


func _execute_bonus_1() -> void:
	pass


func _execute_bonus_2() -> void:
	pass


func _execute_bonus_3() -> void:
	pass
	

func on_signal_received(value = 0):
#	_execute()
	pass


func init_bonus_1() -> void:
	is_bonus_1 = true
	if _signal_bonus1 != "":
		emit_signal("request_signal_trigger1",self)


func init_bonus_2() -> void:
	is_bonus_2 = true
	if _signal_bonus2 != "":
		emit_signal("request_signal_trigger2",self)


func init_bonus_3() -> void:
	is_bonus_3 = true
	if _signal_bonus3 != "":
		emit_signal("request_signal_trigger3",self)


func add_status_on_hero_weapon(status_name: String) -> void:
	hero.hero_weapon.add_status(status_name)
	hero.status_storage.add_status(status_name)
	emit_signal("unlock_secondary", String(Types.keys()[type]) )
	

func awaken() -> void:
	if is_bonus_1 == false:
		init_bonus_1()
	elif is_bonus_2 == false:
		init_bonus_2()
	elif is_bonus_3 == false:
		init_bonus_3()
	else:
		return




