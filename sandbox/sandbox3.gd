extends Node


var current_state: = 0
enum {BUY, UPGRADE}


func _ready():
	var x = 0
	
	if x == 0:
		print("0")
	elif x == 0:
		print("1")
	elif x == 0:
		print("2")
	else:
		print("3")


func _physics_process(delta):
	match current_state:
		BUY:
			pass
		UPGRADE:
			pass
	
