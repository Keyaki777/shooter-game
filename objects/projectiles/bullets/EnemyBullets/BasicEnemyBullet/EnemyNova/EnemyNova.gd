extends KinematicBody2D
class_name EnemyNova


var damage: int setget set_damage
onready var hitbox_2d = $HitBoxArea2D


func explode() -> void:


func set_damage(value) -> void:
	damage = value
	hitbox_2d.damage = damage



func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
