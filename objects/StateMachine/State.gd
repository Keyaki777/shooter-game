extends Node
class_name State

var _state_machine: StateMachine setget set_state_machine
export var min_wait: float = 1
export var max_wait: float = 2
var character
var time_before_next_action : = 1


func unhandled_input(event):
	return


func physics_process(delta):
	return


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func _on_timer_timeout() -> void:
	return


func set_state_machine(new_state_machine) -> void:
	_state_machine = new_state_machine
	character = _state_machine.character
	var all_children = self.get_children()
	for child in all_children:
		if !"_state_machine" in child:
			continue
		child._state_machine = self._state_machine
	initialize()


func start_timer() -> void:
	_state_machine._timer.wait_time = _state_machine.rng.randi_range(min_wait, max_wait)
	if _state_machine._timer.wait_time == 0:
		var x
	_state_machine._timer.start()


func initialize() -> void:
	pass


func is_the_state_machine_state() -> bool:
	if _state_machine.state.name == self.name:
		return true
	else:
		return false

func next_action() -> void:
	pass
