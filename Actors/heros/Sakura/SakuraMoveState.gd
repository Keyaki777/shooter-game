extends State


func unhandled_input(event):
	return


func physics_process(delta):
	character.hero_movement_handler.move()
	character.hero_movement_handler.rotate_to_movement(delta)
	if character.hero_movement_handler.direction == Vector2.ZERO:
		_state_machine.transition_to("Idle")


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func _on_timer_timeout() -> void:
	return
