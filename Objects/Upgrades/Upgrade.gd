extends Node
class_name Upgrade

signal unlock_secondary(secondary_type)
#signal request_signal_connect(upgrade)
#signal request_signal_trigger1(upgrade)
#signal request_signal_trigger2(upgrade)
#signal request_signal_trigger3(upgrade)


enum Types {Normal, Poison, Fire, Water, Ice}
export (Types) var type = Types.Normal

enum Unique_Types{Normal, AttackType, Revenge, Miss, ShieldNova, Critical, ShieldOn, EnemyKilled}
export (Unique_Types) var unique_type = Unique_Types.Normal

#enum Teams{PLAYER, ENEMY}
#export (Teams) var team := Teams.ENEMY

var hero: Hero

var _up_name: String = ""
var _up_effect: String = ""
export var _bonus_level: float = 1.0

#var _atribute_bonus: float = 0

var _bonus_1: String = ""
var _bonus_2: String = ""
var _bonus_3: String = ""
var _scene_path: String = ""

#var category: = 

var level: = 1

# if is already selected to be shown to the player on ui
export var is_selected: bool = false
# if the upgrade have already been bought by the player
export var is_activated: bool = false
# if the upgrade has be unlocked by the player
export var is_unlocked: bool = false
#export var is_signal_connect: bool = false

var is_bonus_1: bool = false
var is_bonus_2: bool = false
var is_bonus_3: bool = false




func initialize() -> void:
	is_activated = true
	on_buy_effect()
	on_buy_signal_connect()


func on_buy_signal_connect() -> void:
	pass



func on_buy_effect() -> void:
	pass


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



func _execute_bonus_1() -> void:
	pass


func _execute_bonus_2() -> void:
	pass


func _execute_bonus_3() -> void:
	pass
	

func on_signal_received(value = 0):
	execute()


func init_bonus_1() -> void:
	is_bonus_1 = true


func init_bonus_2() -> void:
	is_bonus_2 = true


func init_bonus_3() -> void:
	is_bonus_3 = true


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




