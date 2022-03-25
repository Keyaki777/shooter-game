extends KinematicBody2D
class_name Hero

signal total_hp_changed
signal hp_changed
signal died
signal total_shield_changed
signal shield_changed
signal shield_depleted
signal shield_full
signal stopped

signal heal
signal before_hit(damage)
signal before_hurt(damage)
signal hurt(damage)


# can be hurt by another thing (example) status

var target:Enemy
#
#var direction = Vector2.ZERO
#var velocity = Vector2.ZERO

#export var base_speed: int = 300
#export var _rotation_speed: = 180
#var bonus_speed = 0
#var final_speed = 0
#onready var screen_size = get_viewport_rect().size

export var base_hp: float = 1
var bonus_hp: float = 0 setget set_bonus_hp
var bonus_percent_hp: float = 0 setget set_bonus_percent_hp
var _total_hp: int = 0
var hp : float = 0 setget set_hp

export var base_shield: float = 0 setget set_base_shield
var bonus_shield: float = 0 setget set_bonus_shield
var bonus_percent_shield: float = 0 setget set_bonus_percent_shield
var _total_shield: int = 0
var shield: float = 0 setget set_shield
export var shield_regen_base: float = 0.5
export var shield_recharge_cd: float = 2 setget set_shield_recharge_cd

var can_be_hurt: bool = false


onready var shield_recharge_action: = $ShieldRechargeAction
onready var hero_weapon: HeroWeapon = $HeroWeapon
onready var status_storage = $StatusStorage
onready var _tween = $Tween
onready var _shield_source : ShieldSource = $ShieldSource
onready var hero_movement_handler := $HeroMovementHandler


func _ready():
	update_total_hp()
	set_hp(_total_hp)

	update_total_shield()
	set_shield(_total_shield)
	
	shield_recharge_action.character = self
	hero_weapon.character = self
	_shield_source.character = self
	hero_movement_handler.character = self


func _physics_process(delta):
	update_target()


func _powered_up() -> void:
	pass


func set_bonus_shield(value) -> void:
	bonus_shield = value
	update_total_shield()


func set_base_shield(value) -> void:
	base_shield = value
	update_total_shield()
	
	
func set_bonus_percent_shield(value) -> void:
	bonus_percent_shield = value
	update_total_shield()


func update_total_shield() -> void:
	var new_total_shield = base_shield + bonus_shield
	var percentage_of_total_shield = (base_shield + bonus_shield)/100 * bonus_percent_shield
	_total_shield = percentage_of_total_shield + new_total_shield
	emit_signal("total_shield_changed")
	self.shield = self.shield


func set_shield(value) -> void:
	var old_shield = shield
	shield = value
	
	emit_signal("shield_changed")
	
	if shield == 0 and old_shield > 0:
		emit_signal("shield_depleted")
		
	if shield == _total_shield and old_shield < _total_shield:
		emit_signal("shield_full")
		
	if shield < _total_shield and shield <= old_shield:
		if shield_recharge_action:
			shield_recharge_action.start()


func update_total_hp() -> void:
	var percentage_of_total_hp = (bonus_hp + base_hp)/100 * bonus_percent_hp
	_total_hp = base_hp + bonus_hp + percentage_of_total_hp
	emit_signal("total_hp_changed")


func set_hp(value):
	hp = value
	hp = clamp(hp, 0, _total_hp)
	emit_signal("hp_changed")


func set_bonus_hp(value):
	bonus_hp = value
	update_total_hp()


func set_bonus_percent_hp(value) -> void:
	bonus_percent_hp = value
	update_total_hp()


func get_hurt(damage) -> void:
	damage_shield(damage)
	emit_signal("hurt", damage)


func damage_shield(damage) -> void:
	var extra_damage: int = 0
	if damage > shield:
		extra_damage = shield - damage
		damage = shield
		
	self.shield = shield - damage
#	remove later
	if shield < 0:
		print("shield is broken")
	if extra_damage != 0:
		damage_health(abs(extra_damage))


func damage_health(damage) -> void:
	self.hp -= damage


func get_heal() -> void:
	emit_signal("heal")


func _on_HurtBoxArea2D_hit_landed(damage):
	emit_signal("before_hit")
	get_hurt(damage)
	
	
func _input(event):
	if event.is_action_pressed("move_right"):
		_on_HurtBoxArea2D_hit_landed(10)


func set_shield_recharge_cd(value):
		shield_recharge_cd = value
		shield_recharge_action.shield_regen_cooldown.wait_time = shield_recharge_cd


func update_target() -> void:
	var nearest_enemy: Enemy
	var nearest_distance
	var all_enemies = get_tree().get_nodes_in_group("enemys")
	
	if ! all_enemies.empty():
		nearest_enemy = all_enemies[0]
		nearest_distance = self.position.distance_to(all_enemies[0].position)
	
	for enemy in all_enemies:
		var distance_to_this_enemy = self.position.distance_to(enemy.position)
		if distance_to_this_enemy < nearest_distance:
			nearest_distance = distance_to_this_enemy
			nearest_enemy = enemy

	target = nearest_enemy



