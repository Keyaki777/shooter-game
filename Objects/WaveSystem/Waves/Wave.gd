extends Node2D
class_name Wave

signal wave_ended
signal enemy_died
signal object_destroyed


onready var childrens = get_children()
var number_of_childrens = 0
func _ready():
	number_of_childrens = childrens.size()
	for children in childrens:
		children.connect("tree_exited",self,"on_child_exited")
		
		if children.has_signal("died"):
			children.connect("died",self,"on_enemy_died")
	
		if children.has_signal("destroyed"):
			children.connect("destroyed",self,"on_object_destroyed")


func on_child_exited():
	number_of_childrens -= 1
	if number_of_childrens <= 0:
		emit_signal("wave_ended")
		self.queue_free()


func on_enemy_died() -> void:
	emit_signal("enemy_died")


func on_object_destroyed() -> void:
	emit_signal("object_destroyed")


