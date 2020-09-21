extends KinematicBody2D

const MOVE_SPEED = 200 # 100px per sec 

func _process(delta):
	position = get_global_mouse_position()
