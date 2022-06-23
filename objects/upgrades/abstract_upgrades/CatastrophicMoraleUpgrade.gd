extends Upgrade


onready var timer: Timer = $Timer
var effect_state: bool = false
var cooldown: float = 4

func _ready():
	_up_name = "Catastrophic Morale"
	_up_effect = "After a kill, your bullets gain 1 more wall ricochet for 3.5 seconds"
	_scene_path = "res://objects/status/status.tscn"
	timer.connect("timeout", self, "_on_timeout")
	timer.wait_time = cooldown


func _execute(value = 0):
	if effect_state == false:
		effect_state = true
		hero.hero_weapon.max_wall_bounces += 1
		timer.start()


func _unexecute():
	if effect_state == true:
		effect_state = false
		hero.hero_weapon.max_wall_bounces -= 1


func _initialize() -> void:
	pass


func on_buy_effect():
	SignalManager.connect("enemy_death_started", self, "_execute")


func _execute_bonus_1() -> void:
	print("enemy died and bonus 10 executed")


func _execute_bonus_2() -> void:
	pass


func _execute_bonus_3() -> void:
	pass

func _on_timeout() -> void:
	_unexecute()
