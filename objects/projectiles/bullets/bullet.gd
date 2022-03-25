extends KinematicBody2D
class_name Bullet

export var speed: = 10
var direction = Vector2.RIGHT setget set_direction
var velocity: = Vector2.ZERO
var max_wall_bounces: = 0
var walls_bounced: = 0
var enemies_bounced: = 0
var max_enemies_bounces: = 0
onready var enemy_detector: Area2D = $EnemyDetector
onready var raycast2d: RayCast2D = $RayCast2D


func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		bounce(collision_info)


func find_next_target(last_enemy_hurt_box) -> void:
	if !enemies_bounced < max_enemies_bounces:
		destroy()
		return
	var last_enemy = last_enemy_hurt_box.character
	raycast2d.add_exception(last_enemy)
	last_enemy.set_modulate(154)
	var enemies_detected = enemy_detector.get_overlapping_areas()
	for enemy_area in enemies_detected:
		if enemy_area.get_parent() == last_enemy:
			continue
		raycast2d.look_at(enemy_area.global_position)
		raycast2d.rotation_degrees -= 90
		raycast2d.force_raycast_update()
		var collider = raycast2d.get_collider()
		if raycast2d.is_colliding():
#			collider = raycast2d.get_collider()
			if ! collider is Enemy:
				continue
		else:
			continue
		look_at(enemy_area.global_position)
		set_direction(Vector2.RIGHT.rotated(self.global_rotation))
		raycast2d.look_at(enemy_area.global_position)
		raycast2d.rotation_degrees -= 90
		enemies_bounced += 1
		break
	raycast2d.enabled = false

	

func destroy():
	queue_free()


func set_direction(new_direction) -> void:
	direction = new_direction
	velocity = direction * speed
#	set_physics_process(true)


func bounce(collision_info) -> void:
	if walls_bounced < max_wall_bounces:
		walls_bounced += 1
		velocity = velocity.bounce(collision_info.normal)
		global_rotation = velocity.angle()
	else: destroy()


func _on_VisibilityNotifier2D_screen_exited():
	destroy()


#func _enemy_bounce() -> void:
#	pass


func _on_HitBoxArea2D_max_hited():
	destroy()

func _on_HitBoxArea2D_not_last_hit(hurt_box):
	find_next_target(hurt_box)
