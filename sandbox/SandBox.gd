extends Node2D


var def = 0 setget set_def


func set_def(value) -> void:
	print("before" , def)
	def = value
	print("after" , def)

func _input(event):
	if event.is_action_pressed("test_input_1"):
		self.def += 1
	if event.is_action_pressed("test_input_2"):
		self.def = 1
