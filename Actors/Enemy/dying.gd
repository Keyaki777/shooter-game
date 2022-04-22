extends State

export var death_animation: PackedScene

func unhandled_input(event):
	return


func physics_process(delta):
	pass


func enter(msg: Dictionary = {}) -> void:
	character.activated = false
	character.enemy_area.set_deferred("monitoring", false)
	character.hurt_box.is_active = false
	var spawned_death_animation = death_animation.instance()
	spawned_death_animation.global_position = character.global_position
	spawned_death_animation.global_rotation = character.global_rotation
	character.animated_sprite.visible = false
	add_child(spawned_death_animation)
	character.set_is_player_target(false)
	spawned_death_animation.animation_player.connect("animation_finished", self, "_on_animation_finished")
	character.remove_from_group("enemies")
	character.emit_signal("died")

func exit() -> void:
	return


func _on_animation_finished(animation_name: String) -> void:
	character.queue_free()
