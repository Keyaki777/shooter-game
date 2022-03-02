extends Node2D
class_name Hero

signal total_hp_changed
signal heal
signal before_hit(damage)
signal before_hurt(damage)
signal hurt(damage)

# can be hurt by another thing (example) status

var direction = Vector2.ZERO
var velocity = Vector2.ZERO

export var base_speed: int = 10
var bonus_speed = 0
var final_speed = 0
onready var screen_size = get_viewport_rect().size

export var base_hp: int = 1
var bonus_hp: int = 0 setget set_bonus_hp
var bonus_percent_hp: int = 0 setget set_bonus_percent_hp
#setget cuz i want everry time the hp is changed everything linked to it also changes eg.(hp bar or animations trigged)
var _total_hp: = 0
var hp : int = 1

var is_miss: bool = false
var can_be_hurt: bool = false


func _ready():
	set_final_speed()
	yield(get_tree().create_timer(20.0), "timeout")
	get_heal()


func _powered_up() -> void:
	pass


func set_final_speed() -> void:
	final_speed = base_speed + bonus_speed


func set_total_hp() -> void:
	var percentage_of_total_hp = (bonus_hp + base_hp)/100 * bonus_percent_hp
	_total_hp = base_hp + bonus_hp + percentage_of_total_hp
	emit_signal("total_hp_changed")


func set_bonus_hp(value):
	bonus_hp = bonus_hp + value
	set_total_hp()
	
	
func set_bonus_percent_hp(value) -> void:
	bonus_percent_hp += value
	set_total_hp()


func _physics_process(delta):
	movement_handler()
	update_velocity()
	move()
	clamp_position()


func movement_handler() -> void:
	update_direction()


func update_direction() -> void:
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction = direction.normalized()


func update_velocity() -> void:
	velocity = direction * final_speed


func move() -> void:
	translate(velocity)


func clamp_position() -> void:
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func get_hit(final_damage) -> void:
	emit_signal("hurt", final_damage)


func get_heal() -> void:
	emit_signal("heal")


func _on_HurtBoxArea2D_hit_landed(final_damage):
	emit_signal("before_hit")
	if is_miss:
		is_miss = false
		return
	get_hit(final_damage)
