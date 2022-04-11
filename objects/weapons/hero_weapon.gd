extends Node2D
class_name HeroWeapon

var array_of_status_names: Array
var spawned_projectile
export var projectile_scene: PackedScene
var character
export var cooldown_time: float = 0.9
onready var cooldown_timer_node: Timer = $Cooldown
onready var front_cannons = $FrontCannons
onready var diagonal_cannons1 = $DiagonalCannons
onready var diagonal_cannons2 = $DiagonalCannons2
onready var rear_cannon = $RearCannon
onready var side_cannons = $SideCannons
onready var front_cannon = $FrontCannons

var max_enemies_bounces : = 4
var max_wall_bounces : = 4
var max_number_of_hits: = 4
var all_cannons: Array
# 0 = left
var last_front_cannon: int = 0
var critical_chance: int = 0


func _ready():
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
		spawned_projectile_hitbox.critical_chance = 50
		spawned_projectile_hitbox.max_number_of_hits = max_number_of_hits
		spawned_projectile.max_enemies_bounces = max_enemies_bounces
		spawned_projectile.max_wall_bounces = max_wall_bounces
		add_child(spawned_projectile)
		spawned_projectile.set_as_toplevel(true)
		spawned_projectile.global_position = cannon.global_position
		spawned_projectile.global_rotation = cannon.global_rotation
		spawned_projectile.direction = Vector2.RIGHT.rotated(cannon.global_rotation)
		cooldown_timer_node.start()


func _input(event):
	if event.is_action("test_input_1"):
		shoot()
