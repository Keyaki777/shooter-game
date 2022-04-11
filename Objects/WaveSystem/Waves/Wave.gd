extends Node2D
class_name Wave

signal wave_ended
signal enemy_died
signal object_destroyed
signal hero_left

onready var walls: TileMap = $CrateWalls
onready var floor_tilemap: TileMap = $Floor
onready var walkable_tilemap: TileMap = $Navigation2D/WalkableCells
onready var border_walls: TileMap = $BorderWalls
onready var navigation_2d: Navigation2D = $Navigation2D
onready var enemies = $Enemies.get_children()
var number_of_enemies = 0
var standard_tile: int
var hero: Hero = null

func _ready():
	
	var all_heroes_nodes = get_tree().get_nodes_in_group("heroes")
	if all_heroes_nodes.size() > 0:
		hero = all_heroes_nodes[0]
	get_floor_without_walls()


	number_of_enemies = enemies.size()
	for enemy in enemies:
		enemy.wave = self
		
		enemy.on_wave_ready()
		enemy.connect("tree_exited",self,"on_child_exited")
		
		if enemy.has_signal("died"):
			enemy.connect("died",self,"on_enemy_died")
	
		if enemy.has_signal("destroyed"):
			enemy.connect("destroyed",self,"on_object_destroyed")
	


func on_child_exited():
	number_of_enemies -= 1
	if number_of_enemies <= 0:
		emit_signal("wave_ended")
#		self.queue_free()


func on_enemy_died() -> void:
	emit_signal("enemy_died")


func on_object_destroyed() -> void:
	emit_signal("object_destroyed")


func open_one_exit_door() -> void:
	walls.open_one_exit_door()


func _on_Area2D_area_entered(area):
	player_left()


func player_left() -> void:
	emit_signal("hero_left")


func get_floor_without_walls() -> void:
	
	var wall_cells = walls.get_used_cells()
	var border_cells = border_walls.get_used_cells()
	
	for cell in wall_cells:
		walkable_tilemap.set_cell(cell.x, cell.y, -1)
	for cell in border_cells:
		walkable_tilemap.set_cell(cell.x, cell.y, -1)
		
