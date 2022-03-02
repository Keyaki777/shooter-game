extends Area2D
class_name HitBoxArea2D

signal hit_applied

enum Teams{PLAYER, ENEMY}
export (Teams) var team := Teams.ENEMY

export var damage:= 1
export var hit_chance: int = 99

var cant_hit_multiple: bool = false


func apply_hit (hurt_box: HurtBoxArea2D) -> void:
	if team == hurt_box.team:
		return
	set_deferred("monitoring", cant_hit_multiple)
	hurt_box.get_hurt(damage)
	emit_signal("hit_applied")


func _on_HitBoxArea2D_area_entered(area):
	apply_hit(area)
