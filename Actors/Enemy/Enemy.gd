extends Node2D
class_name Enemy

signal died

var hp: int setget set_hp
var bonus_percent_hp: float setget set_bonus_hp
var total_hp: int
export var base_hp: float


func _ready():
	set_total_hp()
	set_hp(total_hp)


func set_hp(value) -> void:
	hp = clamp(value, 0, total_hp)
	print(hp)
	

func set_bonus_hp(value) -> void:
	bonus_percent_hp = value
	set_total_hp()


func set_total_hp() -> void:
	total_hp = base_hp + (base_hp / 100 * bonus_percent_hp)
	print(total_hp)


func get_hurt(damage) -> void:
	self.hp -= damage


func _on_HurtBoxArea2D_hit_landed(damage):
	get_hurt(damage)


func _input(event):
	if event.is_action_pressed("test_input_1"):
		get_hurt(7)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
