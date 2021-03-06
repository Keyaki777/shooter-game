extends Node2D


signal wave_ended
signal all_waves_ended
signal object_destroyed
signal hero_left

export var scene_to_spawn: PackedScene
export var location_number: int = 1

onready var spawned = $Spawned

var path_to_waves: = "res://objects/waveSystem/waves/Level1/" setget set_path_to_waves
var all_waves
var wave_to_spawn: = 0

var spawned_wave


func _ready():
	connect("wave_ended", SignalManager, "_on_wave_spawner_wave_ended")
	connect("all_waves_ended", SignalManager, "_on_wave_spawner_all_waves_ended")
	set_path_to_waves(path_to_waves)


func _on_wave_ended() -> void:
	emit_signal("wave_ended")
	if spawned.get_child_count() == 0:
		emit_signal("all_waves_ended")


func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			
			files.append(file)
	dir.list_dir_end()

	return files


func set_path_to_waves(new_path) -> void:
	all_waves = list_files_in_directory(path_to_waves)
	wave_to_spawn = 0


func instance_next_wave() -> void:
	if !wave_to_spawn < all_waves.size():
		return
	var scene_to_spawn = load(path_to_waves + all_waves[wave_to_spawn])
	spawned_wave = scene_to_spawn.instance()
	add_child(spawned_wave)
	wave_to_spawn += 1
	_connect_signals()


func delete_last_wave() -> void:
	if spawned_wave == null:
		return
	spawned_wave.queue_free()
	_disconnect_signals()
	spawned_wave = null


func _input(event):
	if event.is_action_pressed("test_input_2"):
		delete_last_wave()
		instance_next_wave()


func _connect_signals() -> void:
	spawned_wave.connect("wave_ended", self, "_on_wave_ended")
	spawned_wave.connect("hero_left", self, "_on_wave_hero_left")


func _disconnect_signals() -> void:
	spawned_wave.disconnect("wave_ended", self, "_on_wave_ended")
	spawned_wave.disconnect("hero_left", self, "_on_wave_hero_left")


func open_wave_front_door() -> void:
	spawned_wave.open_one_exit_door()


func _on_wave_hero_left() -> void:
	emit_signal("hero_left")


func call_next_wave() -> void:
	delete_last_wave()
	instance_next_wave()



