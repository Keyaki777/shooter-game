extends Node2D
class_name Enemy


func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		queue_free()
