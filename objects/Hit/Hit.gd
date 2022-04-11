extends Node2D
class_name Hit

var damage: float
var critical_chance: float
var color_of_the_pop_label: Color


func constructor(damage: int, critical_chance: int, color_of_the_pop_label = Color(255,255,255,1)) -> void:
	self.damage = damage
	self.critical_chance = critical_chance
	self.color_of_the_pop_label = color_of_the_pop_label
