extends KinematicBody2D
class_name Enemy

signal died

var hp: int setget set_hp
var bonus_percent_hp: float setget set_bonus_hp
var total_hp: int
export var base_hp: float
onready var hurt_box: = $HurtBoxArea2D

func _ready():
	set_total_hp()
	set_hp(total_hp)
	hurt_box.character = self


func set_hp(value) -> void:
	hp = clamp(value, 0, total_hp)
	$Label.text = String(hp)
	if hp == 0: 
		_die()
	

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



	

func _on_Button_pressed():
	queue_free()

func _die() -> void:
	emit_signal("died")
	queue_free()
	
