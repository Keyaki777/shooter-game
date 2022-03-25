extends Area2D
class_name HitBoxArea2D

signal hit_applied
signal not_last_hit(hurt_box)
signal max_hited


enum Teams{PLAYER, ENEMY}
export (Teams) var team := Teams.ENEMY

export var damage:= 1

export var max_number_of_hits = 0
var number_hited = 0

var damage_source: Node setget set_damage_source
var status_storage


func set_damage_source(new_damage_source: Node) -> void:
	damage_source = new_damage_source
	status_storage = damage_source.character.status_storage


func apply_hit (hurt_box: HurtBoxArea2D) -> void:
	if team == hurt_box.team:
		return
		
	if number_hited >= max_number_of_hits:
		set_deferred("monitoring", false)
		return
	else:
		number_hited += 1
	
	if !hurt_box.is_miss(damage):
		hurt_box.get_hurt(damage)
		apply_status(hurt_box)
	emit_signal("hit_applied")
	
	if number_hited >= max_number_of_hits:
		emit_signal("max_hited")
	else:
		emit_signal("not_last_hit", hurt_box)


func apply_status(hurt_box: HurtBoxArea2D) -> void:
	if !damage_source:
		return
	for status_name in damage_source.array_of_status_names:
#		clone the storage status that corresponds the status_name
		if hurt_box.status.has_node(status_name):
			var existing_status = hurt_box.status.get_node(status_name)
			existing_status.reset()
		else: 
			var original_status = status_storage.get_node(status_name)
			var new_spawned_status = original_status.duplicate()
			new_spawned_status.original_status = original_status
			hurt_box.status.add_child(new_spawned_status)
			new_spawned_status.initialize()


func _on_HitBoxArea2D_area_entered(area):
	apply_hit(area)
