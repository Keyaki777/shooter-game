extends KinematicBody2D
class_name Enemy

signal died
signal damaged
signal moved(enemy_global_position)
signal critical_landed

var is_active:bool = true
var hp: int setget set_hp
var bonus_percent_hp: float setget set_bonus_hp
var total_hp: int
var activated: bool = true
export var base_hp: float
onready var hurt_box: = $HurtBoxArea2D
onready var sprite_animator :AnimationPlayer = $AnimatedSprite/AnimationPlayer
onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var hero_detector: RayCast2D = $RayCast2D
onready var enemy_area = $EnemyArea
var wave setget set_wave
var can_see_player: bool = false setget set_can_see_player
var weapon
var is_player_target: bool = false setget set_is_player_target

export var _rotation_speed: float = 2.4
export var speed = 100
var velocity: Vector2 = Vector2.ZERO
var direction: = Vector2.ZERO

export var is_movement_enemy: bool = false

func _ready():
	hurt_box.connect("critical_landed", self, "_on_hurt_box_critical_landed")
	weapon = $Weapon.get_child(0)
	set_total_hp()
	set_hp(total_hp)
	hurt_box.character = self
	set_process(false)
	set_physics_process(false)


func set_hp(value) -> void:
	hp = clamp(value, 0, total_hp)
	$Label.text = String(hp)
	if hp == 0: 
		_die()
	

func set_bonus_hp(value) -> void:
	bonus_percent_hp = value
	set_total_hp()


func set_total_hp() -> void:
	total_hp = base_hp + (base_hp / 100 * bonus_percent_hp)


func get_hurt(damage) -> void:
	self.hp -= damage
	emit_signal("damaged")
	sprite_animator.play("DamagedAnimation")


func _on_HurtBoxArea2D_hit_landed(damage):
	get_hurt(damage)


func _on_Button_pressed():
	_die()


func _die() -> void:
#	emit_signal("died")
	$StateMachine.transition_to("Die")
#	queue_free()


func _process(delta):
	detect_hero()


func set_wave(new_wave) -> void:
	wave = new_wave
	set_process(true)
	set_physics_process(true)


func detect_hero() -> void:
	if !activated:
		return
	hero_detector.enabled = true
	hero_detector.force_raycast_update()
	hero_detector.look_at(wave.hero.global_position)
	hero_detector.rotation_degrees -= 90
	var collider = hero_detector.get_collider()
	if hero_detector.is_colliding():
		if !collider.is_in_group("heroes"):
			hero_detector.enabled = false
			self.can_see_player = false
			return
	hero_detector.enabled = false
	self.can_see_player = true
	return 


func set_can_see_player(new_value) -> void:
	can_see_player = new_value
#	if can_see_player == true:
#		self.modulate = Color(1,255,1,1)
#	else:
#		self.modulate = Color(255,255,255,255)
#
func on_wave_ready() -> void:
	$StateMachine.set_character(self)


func set_is_player_target(value) -> void:
	is_player_target = value
	$target_sprite.visible = is_player_target


func when_moved() -> void:
	emit_signal("moved", self.global_position)


func _on_hurt_box_critical_landed() -> void:
	emit_signal("critical_landed")
