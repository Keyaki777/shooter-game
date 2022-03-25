extends Node
class_name StatusStorage


func add_status(status_name: String) -> void:
	if has_node(status_name):
		return
	var loaded_status = load("res://objects/Status/AllStatus/" + status_name + ".tscn")
	var spawned_status = loaded_status.instance()
	spawned_status.name = status_name
	add_child(spawned_status)


func _input(event):
	if event.is_action_pressed("test_input_1"):
		add_status("poison")
