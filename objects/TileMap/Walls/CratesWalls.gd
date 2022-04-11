extends TileMap
class_name Wall

var standard_tile:int

func _ready():
#	open_exit_door()
	get_standard_tile()
	standard_tile = get_standard_tile()


func open_one_exit_door() -> void:
	for x in range(6,9):
		set_cell(x, 0, -1)


func get_standard_tile() -> int:
	return get_cell(0,0)
