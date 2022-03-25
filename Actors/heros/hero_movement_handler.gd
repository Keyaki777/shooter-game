extends Node

signal stopped


var character: Hero setget set_character
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

export var base_speed: int = 300
export var _rotation_speed: = 10

var up: = Vector2.ZERO

var bonus_speed = 0
var final_speed = 0

var screen_size


func set_character(new_character):
	character = new_character
	screen_size = character.get_viewport_rect().size
	set_physics_process(true)


func _ready():
	set_final_speed()
	set_physics_process(false)


func _physics_process(delta):
	movement_handler()
	update_velocity()
	move()
	clamp_position()
	aim_handler(delta)


func set_final_speed() -> void:
	final_speed = base_speed + bonus_speed
	
	
func aim_handler(delta) -> void:
	var angle_delta = _rotation_speed * delta
	
	if direction == Vector2.ZERO:
		if !is_instance_valid(character.target):
			character.update_target()
			return

		var v = character.target.global_position - character.global_position
		var angle = v.angle()
		var r = character.global_rotation
		angle = lerp_angle(r, angle, 1)
		angle = clamp(angle, r - angle_delta, r + angle_delta)
		character.global_rotation = angle
	else:
		var angle = velocity.angle()
		angle = lerp_angle(character.global_rotation, angle, 1)
		angle = clamp(angle, character.global_rotation - angle_delta, character.global_rotation + angle_delta)
		character.global_rotation = angle


func movement_handler() -> void:
	update_direction()


func update_direction() -> void:
	var old_direction = direction
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction = direction.normalized()
	if old_direction != Vector2.ZERO and direction == Vector2.ZERO:
		emit_signal("stopped")


func update_velocity() -> void:
	velocity = direction * final_speed


func move() -> void:
#	translate(velocity * delta)
	if velocity != Vector2.ZERO:
		character.move_and_slide(velocity, up)


func clamp_position() -> void:
	character.position.x = clamp(character.position.x, 0, screen_size.x)
	character.position.y = clamp(character.position.y, 0, screen_size.y)
