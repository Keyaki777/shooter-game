extends Node2D

signal hero_heal
signal hero_hurt

onready var hero = $Hero
onready var _upgrade_system = $Upgrade_Handler
onready var _node_animation_player = $AnimationPlayer
onready var _wave_system = $AnimationPlayer/WaveSystem

var wait_for_wave_end: bool = false
var wait_for_all_waves_end:bool = false


func _ready():
	hero.connect("heal", self, "_on_hero_heal")
	hero.connect("hurt", self, "_on_hero_hurt")
	
	_wave_system.connect("wave_ended", self, "_on_wave_system_wave_ended")
	_wave_system.connect("all_waves_ended", self, "_on_wave_system_all_waves_ended")
	
	_upgrade_system.connect("upgrade_ended", self, "_on_upgrade_handler_upgrade_ended")
	_upgrade_system.connect("upgrade_connect_request", self, "_on_upgrade_connect_request")

	_upgrade_system.hero = self.hero


func _show_upgrade_ui() -> void:
	_upgrade_system.visible = true


func _hide_upgrade_ui() -> void:
	_upgrade_system.visible = false


func on_wave_system_play_next() -> void:
	_animation_play()


func _animation_stop() -> void:
	_node_animation_player.stop()


func _animation_pause() -> void:
	_node_animation_player.stop(false)


func _animation_play() -> void:
	_node_animation_player.play()


func show_upgrade() -> void:
	_show_upgrade_ui()
	_animation_pause()


func _on_upgrade_handler_upgrade_ended():
	_hide_upgrade_ui()
	_animation_play()


func _on_wave_system_wave_ended():
	if wait_for_wave_end == true:
		wait_for_wave_end = false
		_animation_play()


func _on_wave_system_all_waves_ended():
	if wait_for_all_waves_end == true:
		wait_for_all_waves_end = false
		_animation_play()


func set_wait_for_wave_end():
	wait_for_wave_end = true
	_animation_pause()


func set_wait_for_all_waves_to_end():
	wait_for_all_waves_end = true
	_animation_pause()


func _on_upgrade_connect_request(upgrade: Upgrade) -> void:
	self.connect(upgrade._signal_connect, upgrade, "on_signal_received")
	

func _on_hero_hurt(final_damage) -> void:
	emit_signal("hero_hurt", final_damage)


func _on_hero_heal() -> void:
	emit_signal("hero_heal")
