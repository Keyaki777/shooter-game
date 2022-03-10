extends Node2D

signal hero_heal
signal hero_hurt
signal enemy_died
signal object_destroyed
signal hero_shield_full
signal hero_shield_depleted

onready var hero = $Hero
onready var _upgrade_handler = $UpgradeHandler
onready var _node_animation_player = $AnimationPlayer
onready var _wave_system = $AnimationPlayer/WaveSystem
onready var _spawner = $AnimationPlayer/WaveSystem/Spawner

onready var _health_bar :ProgressBar = $CanvasLayer/Ui/HealthBar
onready var _health_label : Label = $CanvasLayer/Ui/HealthBar/HealthLabel
onready var _shield_bar :ProgressBar = $CanvasLayer/Ui/ShieldBar
onready var _shield_label :Label = $CanvasLayer/Ui/ShieldBar/ShieldLabel

var wait_for_wave_end: bool = false
var wait_for_all_waves_end:bool = false


func _ready():
	_upgrade_handler.hero = self.hero
	
	hero.connect("heal", self, "_on_hero_heal")
	hero.connect("hurt", self, "_on_hero_hurt")
	hero.connect("hp_changed", self, "_on_hero_hp_changed")
	hero.connect("total_hp_changed", self, "_on_hero_total_hp_changed")
	hero.connect("shield_changed", self, "_on_hero_shield_changed")
	hero.connect("total_shield_changed", self, "_on_hero_total_shield_changed")
	hero.connect("shield_depleted", self, "_on_hero_shield_depleted")
	hero.connect("shield_full", self, "_on_hero_shield_full")
	
	_wave_system.connect("wave_ended", self, "_on_wave_system_wave_ended")
	_wave_system.connect("all_waves_ended", self, "_on_wave_system_all_waves_ended")
	
	_upgrade_handler.connect("upgrade_ended", self, "_on_upgrade_handler_upgrade_ended")
	_upgrade_handler.connect("upgrade_connect_request", self, "_on_upgrade_connect_request")
	_upgrade_handler.connect("request_signal_trigger10", self, "_on_request_signal_trigger10")
	_upgrade_handler.connect("request_signal_trigger20", self, "_on_request_signal_trigger20")
	_upgrade_handler.connect("request_signal_trigger30", self, "_on_request_signal_trigger30")
	
	
	_spawner.connect("enemy_died", self, "_on_Spawner_enemy_died")
	_spawner.connect("object_destroyed", self, "_on_Spawner_object_destroyed")

	_on_hero_total_hp_changed()
	_on_hero_hp_changed()
	_on_hero_total_shield_changed()
	_on_hero_shield_changed()


func _show_upgrade_ui() -> void:
	_upgrade_handler.visible = true


func _hide_upgrade_ui() -> void:
	_upgrade_handler.visible = false


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


func _on_request_signal_trigger10(upgrade: Upgrade) -> void:
	self.connect(upgrade._signal_bonus10, upgrade, "_execute_bonus_10")


func _on_request_signal_trigger20(upgrade: Upgrade) -> void:
	self.connect(upgrade._signal_bonus20, upgrade, "_execute_bonus_20")


func _on_request_signal_trigger30(upgrade: Upgrade) -> void:
	self.connect(upgrade._signal_bonus30, upgrade, "_execute_bonus_30")


func _on_hero_hurt(final_damage) -> void:
	emit_signal("hero_hurt", final_damage)


func _on_hero_heal() -> void:
	emit_signal("hero_heal")


func _on_Spawner_enemy_died():
	emit_signal("enemy_died")


func _on_Spawner_object_destroyed():
	emit_signal("object_destroyed")


func _on_hero_shield_depleted():
	emit_signal("hero_shield_depleted")


func _on_hero_shield_full():
	emit_signal("hero_shield_full")


func _on_hero_hp_changed() -> void:
	_health_bar.value = hero.hp
	_health_label.text = String(hero.hp) + "/" + String(hero._total_hp)


func _on_hero_total_hp_changed() -> void:
	_health_bar.max_value = hero._total_hp
	_health_label.text = String(hero.hp) + "/" + String(hero._total_hp)


func _on_hero_shield_changed() -> void:
	_shield_bar.value = hero.shield
	_shield_label.text = String(hero.shield) + "/" + String(hero._total_shield)


func _on_hero_total_shield_changed() -> void:
	_shield_bar.max_value = hero._total_shield
	_shield_label.text = String(hero.shield) + "/" + String(hero._total_shield)


func toggle_shield_ui_visibility() -> void:
	_shield_bar.visible = ! _shield_bar.visible
	
	
