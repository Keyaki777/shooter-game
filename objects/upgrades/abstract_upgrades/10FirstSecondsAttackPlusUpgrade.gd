extends Upgrade

var bonus_damage := 10.0
var cooldown_counter: float = 15

onready var _timer := $Timer


func _ready():
	_up_name = "Hyper Space Discharge"
	_up_effect = "Get 10% bonus shoot attack the first 15 seconds of each chamber"
	_timer.connect("timeout", self, "_on_timeout")	
	_scene_path = "res://objects/status/status.tscn"
	_timer.wait_time = cooldown_counter


func update_labels() -> void:
	_atribute_description = "your attack: " + String(hero.hero_weapon._total_damage)


func _execute(value = 0):
	hero.hero_weapon._percent_bonus_damage += bonus_damage
	_timer.start()


func _unexecute():
	hero.hero_weapon._percent_bonus_damage -= bonus_damage


func _initialize() -> void:
	pass


func on_buy_effect():
	SignalManager.connect("level_entered", self, "_execute")


func on_signal_received(value = 0):
	_execute()


func _execute_bonus_1() -> void:
	print("enemy died and bonus 10 executed")


func _execute_bonus_2() -> void:
	pass


func _execute_bonus_3() -> void:
	pass

func _on_timeout() -> void:
	_unexecute()
