extends Node2D
class_name HeroWeapon

var array_of_status_names: Array
var spawned_projectile
export var projectile_scene: PackedScene
var character
export var cooldown_time: float = 0.9 setget set_cooldown
export var _base_damage: int = 0
var _total_damage: int = 2
var _bonus_damage = 0 setget set_bonus_damage
var _percent_bonus_damage = 0 setget set_percent_damage
onready var cooldown_timer_node: Timer = $Cooldown
onready var front_cannons = $FrontCannons
onready var diagonal_cannons1 = $DiagonalCannons
onready var diagonal_cannons2 = $DiagonalCannons2
onready var rear_cannon = $RearCannon
onready var side_cannons = $SideCannons
onready var front_cannon = $FrontCannons
export var splash_path: NodePath
var splash_animated_sprite


var max_enemies_bounces : = 0 setget set_max_enemies_bounces
var max_wall_bounces : = 0
var max_number_of_hits: = 4
var all_cannons: Array
# 0 = left
var last_front_cannon: int = 0
var critical_chance: int = 0


func _ready():
	splash_animated_sprite = get_node(splash_path)
	update_total_damage()
	cooldown_timer_node.wait_time = cooldown_time
	add_front_cannon()
	
#	add_diagonal_cannons1()
#	add_rear_cannon()
#	add_diagonal_cannons2()
#	add_side_cannons()


func add_front_cannon() -> void:
	var cannons_to_add = front_cannon.get_children()
	for cannon in cannons_to_add:
		all_cannons.append(cannon)


func add_diagonal_cannons1() -> void:
	var cannons_to_add = diagonal_cannons1.get_children()
	for cannon in cannons_to_add:
		all_cannons.append(cannon)


func add_diagonal_cannons2() -> void:
	var cannons_to_add = diagonal_cannons2.get_children()
	for cannon in cannons_to_add:
		all_cannons.append(cannon)


func add_rear_cannon() -> void:
	var cannons_to_add = rear_cannon.get_children()
	for cannon in cannons_to_add:
		all_cannons.append(cannon)


func add_side_cannons() -> void:
	var cannons_to_add = side_cannons.get_children()
	for cannon in cannons_to_add:
		all_cannons.append(cannon)



func add_status(status_name: String) -> void:
	array_of_status_names.append(status_name)


func shoot() -> void:
	if !cooldown_timer_node.is_stopped():
		return

	for cannon in all_cannons:
		spawned_projectile = projectile_scene.instance() 
		var spawned_projectile_hitbox = spawned_projectile.get_node("HitBoxArea2D")
		spawned_projectile_hitbox.damage_source = self
		spawned_projectile_hitbox.team = 0
		spawned_projectile_hitbox.damage = _total_damage
		spawned_projectile_hitbox.critical_chance = 50
		spawned_projectile_hitbox.max_number_of_hits = max_number_of_hits
		spawned_projectile.max_enemies_bounces = max_enemies_bounces
		spawned_projectile.max_wall_bounces = max_wall_bounces
		add_child(spawned_projectile)
		spawned_projectile.set_as_toplevel(true)
		spawned_projectile.global_position = cannon.global_position
		spawned_projectile.global_rotation = cannon.global_rotation
		spawned_projectile.direction = Vector2.RIGHT.rotated(cannon.global_rotation)
		play_splash_sprite()
		cooldown_timer_node.start()


func _input(event):
	if event.is_action_pressed("test_input_4"):
		improve_cooldown()


func update_total_damage() -> void:
	var percent_bonus_damage = _percent_bonus_damage/100 * (_base_damage + _bonus_damage)
	_total_damage = _percent_bonus_damage + _base_damage + _bonus_damage


func set_percent_damage(value) -> void:
	_percent_bonus_damage = value
	update_total_damage()


func set_bonus_damage(value) -> void:
	_bonus_damage = value
	update_total_damage()


func play_splash_sprite() -> void:
	splash_animated_sprite.frame = 0


func set_max_enemies_bounces(value) -> void:
	max_enemies_bounces = value
	max_number_of_hits = max_enemies_bounces +1


func set_cooldown(value) -> void:
	cooldown_time =  value
	if !cooldown_timer_node:
		return
	cooldown_timer_node.wait_time = cooldown_time


func improve_cooldown() -> void:
	self.cooldown_time = cooldown_time - (cooldown_time * 0.3)
	print(cooldown_time)



