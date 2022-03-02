extends Area2D
class_name HurtBoxArea2D

signal hit_landed(damage)
signal healed_by_value(heal_value)
signal healed_by_percent(heal_percent_value)

enum Teams{PLAYER, ENEMY}
export (Teams) var team:= Teams.ENEMY
#armor
var total_armor:= 0
export var base_armor: = 0
var bonus_armor = 0 setget set_bonus_armor
var bonus_percent_armor = 0 setget set_bonus_percent_armor
 
var character: Node2D 


func get_hurt(damage) -> void:
	var final_damage := clamp((damage - total_armor),1,10000)
	emit_signal("hit_landed", final_damage)


func set_bonus_armor(value) -> void:
	bonus_armor += value
	set_total_armor()


func set_bonus_percent_armor(value) -> void:
	bonus_percent_armor += value
	set_total_armor()


func set_total_armor() -> void:
	var new_total_armor = base_armor + bonus_armor
	new_total_armor = new_total_armor + (new_total_armor/100 * bonus_percent_armor)
	total_armor = new_total_armor


