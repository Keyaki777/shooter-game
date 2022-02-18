extends Node2D
class_name Wave

signal wave_ended

onready var childrens = get_children()
var number_of_childrens = 0
func _ready():
	number_of_childrens = childrens.size()
	for children in childrens:
		children.connect("tree_exited",self,"on_child_exited")

func on_child_exited():
	number_of_childrens -= 1
	if number_of_childrens <= 0:
		emit_signal("wave_ended")
		self.queue_free()
