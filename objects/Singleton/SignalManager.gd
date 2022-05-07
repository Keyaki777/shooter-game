extends Node

signal camera_shake_requested


func camera_shake_requested() -> void:
	emit_signal("camera_shake_requested")
