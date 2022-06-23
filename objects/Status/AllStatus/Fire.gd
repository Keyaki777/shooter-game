extends Status


func _ready():
	set_process(false)
	
#	remote_transform.set_as_toplevel(true)


func status_execute() -> void:
	create_hit(modifier)
	proc_timer_node.start()
	


func status_cancel() -> void:
	queue_free()


func _physics_process(delta):
	$Particles2D.global_rotation = 0


func set_original_status(new_original_status: Status) -> void:
	pass


#func create_hit(damage: int = 1, critical_chance: int = 0,color: Color = self.color ,global_position: Vector2 = hurtbox.global_position) -> Hit:
#	var this_hit: Hit = Hit.new()
#	this_hit.constructor(damage, critical_chance, self.color, self.global_position)
#	hurtbox.get_hurt(this_hit)
#	return this_hit
#
#
#func _on_Exaust_Timer_timeout():
#	status_cancel()
#
#
#func _on_Proc_Timer_timeout():
#	status_execute()

