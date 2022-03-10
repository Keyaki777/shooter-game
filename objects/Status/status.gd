extends Node
class_name Status

var hurtbox: HurtBoxArea2D
var character: Node2D
var original_status: Status setget set_original_status

func _ready():
	set_process(false)


func status_execute() -> void:
	pass


func status_cancel() -> void:
	pass


func initialize() -> void:
	$Timer.start()
	


func reset() -> void:
	$Timer.start()
	

func set_original_status(new_original_status: Status) -> void:
	pass


func _on_Timer_timeout():
	queue_free()
