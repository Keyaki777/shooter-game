extends Node2D
class_name Wave

signal wave_ended
signal enemy_died
signal object_destroyed
signal hero_left
signal enemy_critical_landed

onready var walls: TileMap = $CrateWalls
onready var floor_tilemap: TileMap = $Floor
onready var walkable_tilemap: TileMap = $Navigation2D/WalkableCells
var walkable_cells: Array
onready var border_walls: TileMap = $BorderWalls
onready var navigation_2d: Navigation2D = $Navigation2D
onready var enemies = $Enemies.get_children()
var number_of_enemies = 0
var standard_tile: int
var hero: Hero = null
onready var _player_start_position: Position2D = $PlayerStartPosition


func _ready():
	
	var all_heroes_nodes = get_tree().get_nodes_in_group("heroes")
	if all_heroes_nodes.size() > 0:
		hero = all_heroes_nodes[0]
	get_floor_without_walls()
	init_walkable_cells()
	print(walkable_tilemap.world_to_map(Vector2(539,1570)))
	

	number_of_enemies = enemies.size()
	for enemy in enemies:
		enemy.wave = self
		
		if !enemy.is_movement_enemy:
			_on_enemy_moved_on_tile(Vector2(-5,-5), enemy.global_position)
		
		enemy.on_wave_ready()
		enemy.connect("tree_exited",self,"_on_child_exited")
		enemy.connect("moved_on_tile", self, "_on_enemy_moved_on_tile")
		enemy.connect("critical_landed", self, "_on_enemy_critical_laned")
		
		if enemy.has_signal("died"):
			enemy.connect("died", self, "_on_enemy_died")
	
		if enemy.has_signal("destroyed"):
			enemy.connect("destroyed",self,"_on_object_destroyed")


func _on_child_exited():
	number_of_enemies -= 1
	if number_of_enemies <= 0:
		emit_signal("wave_ended")
#		self.queue_free()


func _on_enemy_died() -> void:
	emit_signal("enemy_died")


func _on_object_destroyed() -> void:
	emit_signal("object_destroyed")


func open_one_exit_door() -> void:
	for x in range(6,10):
		yield(get_tree().create_timer(1.0), "timeout")
		border_walls.set_cell(x, 0, -1)


func _on_Area2D_area_entered(area):
	player_left()


func player_left() -> void:
	emit_signal("hero_left")


func _on_enemy_critical_laned() -> void:
	emit_signal("enemy_critical_landed")


func get_floor_without_walls() -> void:
	var wall_cells = walls.get_used_cells()
	var border_cells = border_walls.get_used_cells()
	
	for cell in wall_cells:
		walkable_tilemap.set_cell(cell.x, cell.y, -1)
	for cell in border_cells:
		walkable_tilemap.set_cell(cell.x, cell.y, -1)

func init_walkable_cells() -> void:
	var number_of_walkable_cells = walkable_tilemap.get_used_cells().size()
	for i in range(number_of_walkable_cells):
		walkable_cells.append(0)


func _on_enemy_moved_on_tile(last_position: Vector2,new_position: Vector2) -> void:
	if last_position == new_position:
		return
	var last_position_on_tile = walkable_tilemap.world_to_map(last_position)
	var new_position_on_tile = walkable_tilemap.world_to_map(new_position)
	var i: int = 0
	
	for this_cell in walkable_tilemap.get_used_cells():
		if this_cell == last_position_on_tile:
			walkable_cells[i] -= 1
			if walkable_cells[i] == 0:
				walkable_tilemap.set_cell(last_position_on_tile.x,last_position_on_tile.y, 0)
			
		if this_cell == new_position_on_tile:
			walkable_cells[i] += 1
			if walkable_cells[i] > 0:
				walkable_tilemap.set_cell(new_position_on_tile.x, new_position_on_tile.y, 1)
		
		i += 1
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
