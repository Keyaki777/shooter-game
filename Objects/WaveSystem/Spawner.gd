extends Node2D

signal wave_ended
signal all_waves_ended
signal enemy_died
signal object_destroyed

export var scene_to_spawn: PackedScene
export var location_number: int = 1

onready var spawned = $Spawned
onready var locations = $Locations.get_children()

var spawling: Wave
export var selected_position: NodePath

#func _ready():
#	spawn(Vector2(30,0))

func spawn(offset: Vector2):
	
	
	spawling = scene_to_spawn.instance()
	spawling.connect("wave_ended", self, "_on_wave_ended")
	spawling.connect("enemy_died", self, "_on_wave_enemy_died")
	spawling.connect("object_destroyed", self, "_on_wave_object_destroyed")

	
	add_child(spawling)
	spawling.set_as_toplevel(true)
	spawling.global_position = locations[location_number].global_position
	

func _on_wave_ended() -> void:
	emit_signal("wave_ended")
	if spawned.get_child_count() == 0:
		emit_signal("all_waves_ended")


func _on_wave_enemy_died() -> void:
	emit_signal("enemy_died")
	

func _on_wave_object_destroyed() -> void:
	emit_signal("object_destroyed")
