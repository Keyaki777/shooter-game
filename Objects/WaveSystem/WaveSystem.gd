extends Node2D

signal play

onready var spawner = $Spawner

export var play_on_wave_ended: bool = false
export var play_on_all_waves_ended: bool = false
export var delay_between_waves: int = 1


func _ready():
	spawner.connect("all_waves_ended", self, "on_spawner_all_waves_ended")
	spawner.connect("wave_ended", self, "wave_ended")


func on_spawner_all_waves_ended() -> void:
	if play_on_all_waves_ended:
		play_next()


func wave_ended() -> void:
	if play_on_wave_ended:
		play_next()


func play_next():
	emit_signal("play")
