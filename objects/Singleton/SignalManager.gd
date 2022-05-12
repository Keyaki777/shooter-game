extends Node


signal camera_shake_requested

signal enemy_died
signal object_destroyed
signal hero_total_shield_changed
signal hero_heal
signal hero_hurt
signal hero_shield_full
signal hero_shield_depleted
signal hero_hp_changed
signal hero_total_hp_changed
signal hero_shield_changed
signal enemy_critical_landed
signal on_hero_left
signal wave_ended
signal all_waves_ended
signal upgrade_animation_started
signal upgrade_animation_finished
signal level_entered
signal level_exited


var _hero: Hero setget _set_hero


func camera_shake_requested() -> void:
	emit_signal("camera_shake_requested")


func _set_hero(new_hero) -> void:
	_hero = new_hero

	
func _on_hero_hurt(final_damage) -> void:
	emit_signal("hero_hurt", final_damage)


func _on_hero_heal() -> void:
	emit_signal("hero_heal")


func _on_hero_hp_changed() -> void:
	emit_signal("hero_hp_changed")


func _on_hero_total_hp_changed() -> void:
	emit_signal("hero_total_hp_changed")


func _on_hero_shield_changed() -> void:
	emit_signal("hero_shield_changed")


func _on_hero_total_shield_changed() -> void:
	emit_signal("hero_total_shield_changed")


func _on_hero_shield_depleted():
	emit_signal("hero_shield_depleted")


func _on_hero_shield_full() -> void:
	emit_signal("hero_shield_full")


func _on_enemy_critical_landed(critical_value) -> void:
	emit_signal("enemy_critical_landed")


func _on_enemy_died():
	emit_signal("enemy_died")


func _on_object_destroyed():
	emit_signal("object_destroyed")


func _on_wave_spawner_wave_ended(): 
	emit_signal("wave_ended")


func _on_wave_spawner_all_waves_ended():
	emit_signal("all_waves_ended")


func _on_hero_left() -> void:
	emit_signal("on_hero_left")


func upgrade_animation_finished() -> void:
	emit_signal("upgrade_animation_finished")


func upgrade_animation_started() -> void:
	emit_signal("upgrade_animation_started")


func _on_level_entered() -> void:
	emit_signal("level_entered")

func _on_level_exited() -> void:
	emit_signal("level_exited")
