extends KinematicBody2D
class_name TargetEnemyBullet


export var explosion_particle_scene : PackedScene
onready var _animation_player: AnimationPlayer = $AnimationPlayer
onready var _target_sprite : Sprite = $Target_Sprite

#func _physics_process(delta):
#	var collision_info = move_and_collide(velocity)
#	if collision_info:
#		explode()


#func explode() -> void:
#	instance_explosion_particle()
#	queue_free()


#func set_direction(new_direction) -> void:
#	direction = new_direction
#	velocity = direction * speed


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_HitBoxArea2D_hit_applied():
	pass


func instance_explosion_particle() -> void:
	var particle = explosion_particle_scene.instance()
	particle.this_global_position = self.global_position
	particle.modulate = $Sprite.modulate
	get_parent().add_child(particle)
	particle.destroy_explosion_after_time()


func _on_AnimationPlayer_animation_finished(anim_name):
	pass


func _set_target_sprite(target_location):
	$Target_Sprite.global_position = _target_sprite.global_position


