extends Node2D
class_name Bullet

export var speed: = 10



func _physics_process(delta):
	translate(Vector2.UP * speed)


func _on_HitBoxArea2D_hit_applied():
	queue_free()
