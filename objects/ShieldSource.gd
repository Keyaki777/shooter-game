extends Node2D
class_name ShieldSource

var array_of_status_names: Array
var shield_nova
export var projectile_scene: PackedScene
var character


func add_status(status_name: String) -> void:
	array_of_status_names.append(status_name)


func Nova() -> void:
	shield_nova = projectile_scene.instance() 
	var shield_nova_hitbox = shield_nova.get_node("HitBoxArea2D")
	shield_nova_hitbox.damage_source = self
	shield_nova_hitbox.team = 0
	add_child(shield_nova)
	shield_nova.set_as_toplevel(true)
	shield_nova.global_position = self.global_position


func _input(event):
	if event.is_action("test_input_1"):
		Nova()

