extends Control




func set_current_state(value) -> void:
	$VBoxContainer/HBoxContainer2/lastvalue.text = $VBoxContainer/HBoxContainer/Currentvalue.text
	$VBoxContainer/HBoxContainer/Currentvalue.text = String(value)


func _on_StateMachine_state_entered(state_name):
	set_current_state(state_name)
