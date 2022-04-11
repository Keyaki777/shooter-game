extends Node2D

signal _hero_heal
signal _hero_hurt
signal enemy_died
signal object_destroyed
signal _hero_shield_full
signal _hero_shield_depleted

onready var _hero = $HeroContainer.get_child(0)
onready var _upgrade_handler = $CanvasLayer/Ui/UpgradeHandler
#onready var _node_animation_player = $AnimationPlayer
onready var _wave_spawner = $WaveSpawner

onready var _health_bar :ProgressBar = $CanvasLayer/Ui/HealthBar
onready var _health_label : Label = $CanvasLayer/Ui/HealthBar/HealthLabel
onready var _shield_bar :ProgressBar = $CanvasLayer/Ui/ShieldBar
onready var _shield_label :Label = $CanvasLayer/Ui/ShieldBar/ShieldLabel
onready var _transition_rect: TransitionRect = $CanvasLayer/Ui/TransitionRect
onready var _reward_handler: = $RewardHandler

func _ready():
	_upgrade_handler.hero = self._hero
	
	_hero.connect("heal", self, "_on_hero_heal")
	_hero.connect("hurt", self, "_on_hero_hurt")
	_hero.connect("hp_changed", self, "_on_hero_hp_changed")
	_hero.connect("total_hp_changed", self, "_on_hero_total_hp_changed")
	_hero.connect("shield_changed", self, "_on_hero_shield_changed")
	_hero.connect("total_shield_changed", self, "_on_hero_total_shield_changed")
	_hero.connect("shield_depleted", self, "_on_hero_shield_depleted")
	_hero.connect("shield_full", self, "_on_hero_shield_full")
	
	_wave_spawner.connect("wave_ended", self, "_on_wave_spawner_wave_ended")
	_wave_spawner.connect("all_waves_ended", self, "_on_wave_spawner_all_waves_ended")
	_wave_spawner.connect("enemy_died", self, "_on_Spawner_enemy_died")
	_wave_spawner.connect("object_destroyed", self, "_on_Spawner_object_destroyed")
	_wave_spawner.connect("hero_left", self, "_on_Spawner_hero_left")
	
	_upgrade_handler.connect("upgrade_ended", self, "_on_upgrade_handler_upgrade_ended")
	_upgrade_handler.connect("upgrade_connect_request", self, "_on_upgrade_connect_request")
	_upgrade_handler.connect("request_signal_trigger1", self, "_on_request_signal_trigger1")
	_upgrade_handler.connect("request_signal_trigger2", self, "_on_request_signal_trigger2")
	_upgrade_handler.connect("request_signal_trigger3", self, "_on_request_signal_trigger3")
	
	_reward_handler.connect("reward_activated", self, "_on_reward_handler_activated")
	
	
	_on_hero_total_hp_changed()
	_on_hero_hp_changed()
	_on_hero_total_shield_changed()
	_on_hero_shield_changed()
	start_level()

func _show_upgrade_ui() -> void:
	_upgrade_handler.visible = true


func _hide_upgrade_ui() -> void:
	_upgrade_handler.visible = false


func _show_upgrade() -> void:
	_show_upgrade_ui()
#	_animation_pause()
	upgrade_pause()


func _on_upgrade_handler_upgrade_ended():
	_hide_upgrade_ui()
	upgrade_pause()
	_wave_spawner.open_wave_front_door()


func _on_wave_spawner_wave_ended():
	_reward_handler.spawn_reward("BuyReward", _hero.global_position)


func _on_wave_spawner_all_waves_ended():
	pass


func _on_upgrade_connect_request(upgrade: Upgrade) -> void:
	self.connect(upgrade._signal_connect, upgrade, "on_signal_received")


func _on_request_signal_trigger1(upgrade: Upgrade) -> void:
	self.connect(upgrade._signal_bonus10, upgrade, "_execute_bonus_10")


func _on_request_signal_trigger2(upgrade: Upgrade) -> void:
	self.connect(upgrade._signal_bonus20, upgrade, "_execute_bonus_20")


func _on_request_signal_trigger3(upgrade: Upgrade) -> void:
	self.connect(upgrade._signal_bonus30, upgrade, "_execute_bonus_30")


func _on_hero_hurt(final_damage) -> void:
	emit_signal("_hero_hurt", final_damage)


func _on_hero_heal() -> void:
	emit_signal("_hero_heal")


func _on_Spawner_enemy_died():
	emit_signal("enemy_died")


func _on_Spawner_object_destroyed():
	emit_signal("object_destroyed")


func _on_hero_shield_depleted():
	emit_signal("_hero_shield_depleted")


func _on_hero_shield_full():
	emit_signal("_hero_shield_full")


func _on_hero_hp_changed() -> void:
	_health_bar.value = _hero.hp
	_health_label.text = String(_hero.hp) + "/" + String(_hero._total_hp)


func _on_hero_total_hp_changed() -> void:
	_health_bar.max_value = _hero._total_hp
	_health_label.text = String(_hero.hp) + "/" + String(_hero._total_hp)


func _on_hero_shield_changed() -> void:
	_shield_bar.value = _hero.shield
	_shield_label.text = String(_hero.shield) + "/" + String(_hero._total_shield)


func _on_hero_total_shield_changed() -> void:
	_shield_bar.max_value = _hero._total_shield
	_shield_label.text = String(_hero.shield) + "/" + String(_hero._total_shield)


func toggle_shield_ui_visibility() -> void:
	_shield_bar.visible = ! _shield_bar.visible


func upgrade_pause() -> void:
	get_tree().paused = !get_tree().paused


func start_level() -> void:
	_wave_spawner.call_next_wave()
	_transition_rect.transition_in()


func _on_reward_handler_activated(reward_name: String) -> void:
	match reward_name:
		"BuyReward":
			_show_upgrade()


func reset_hero_position() -> void:
	_hero.global_position = Vector2(540, 1820)
	_hero.global_rotation = -90


func _on_Spawner_hero_left() -> void:
	call_next_level()


func call_next_level() -> void:
	_transition_rect.transition_out()
	yield(_transition_rect, "transition_ended")
	_wave_spawner.call_next_wave()
	reset_hero_position()
	yield(get_tree().create_timer(1.0), "timeout")
	_transition_rect.transition_in()
