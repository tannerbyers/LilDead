extends KinematicBody2D

const ACCELERATION = 512
const MAX_SPEED = 64
const FRICTION = 0.25
const AIR_RESISTANCE = 0.01
const GRAVITY = 300
const JUMP_FORCE = 128

var jumps_left = 1

var motion = Vector2.ZERO

onready var sprite = $AnimatedSprite

func _physics_process(delta):
	var x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	
	if x_input != 0:
		sprite.play("run")
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0
	else:
		sprite.play("idle")

	motion.y += GRAVITY * delta
	
	if is_on_floor():
		jumps_left = 1
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
			
		if Input.is_action_just_pressed("up"):
			motion.y = -JUMP_FORCE
			jumps_left -= 1
	else: 
		if next_to_wall():
			jumps_left = 1
			if Input.is_action_just_pressed("up"):
				jumps_left -= 1
				motion.y = -JUMP_FORCE
				if next_to_left_wall():
					motion.x += JUMP_FORCE

				if next_to_right_wall():
					motion.x -= JUMP_FORCE
#
		if Input.is_action_just_released("up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
	
	motion = move_and_slide(motion, Vector2.UP)
	
func next_to_wall():
	return next_to_left_wall() or next_to_right_wall()
	
func next_to_right_wall():
	return $RightRayCast2D.is_colliding() or $RightRayCast2D2.is_colliding()
	
func next_to_left_wall():
	return $LeftRayCast2D.is_colliding() or $LeftRayCast2D2.is_colliding()
