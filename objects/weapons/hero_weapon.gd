extends Node2D
class_name HeroWeapon

var array_of_status_names: Array
var spawned_projectile
export var projectile_scene: PackedScene
var character


func add_status(status_name: String) -> void:
	array_of_status_names.append(status_name)


func shoot() -> void:
	spawned_projectile = projectile_scene.instance() 
	var spawned_projectile_hitbox: HitBoxArea2D = spawned_projectile.get_node("HitBoxArea2D")
	spawned_projectile_hitbox.damage_source = self
	spawned_projectile_hitbox.team = 0
	add_child(spawned_projectile)
	spawned_projectile.set_as_toplevel(true)
	spawned_projectile.global_position = self.global_position
	


func _input(event):
	if event.is_action("test_input_1"):
		shoot()
