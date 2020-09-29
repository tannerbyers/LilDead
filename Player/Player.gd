extends KinematicBody2D

const ACCELERATION = 512
const MAX_SPEED = 64
const FRICTION = 0.25
const AIR_RESISTANCE = 0.01
const GRAVITY = 300
const JUMP_FORCE = 128
var attack_cooldown_time = 1000
var next_attack_time = 0

var jumps_left = 2
var lantern_held = false
var attack_playing = false

var motion = Vector2.ZERO

var life = 3

onready var sprite = $AnimatedSprite

func _input(event):
	if event.is_action_pressed("attack"):
	# Check if player can attack
		if lantern_held:
			print("attacking")
			var now = OS.get_ticks_msec()
			if now >= next_attack_time:
				# Play attack animation
				attack_playing = true
				sprite.play("attack")
				is_hitting_enemy()
				# Add cooldown time to current time
				next_attack_time = now + attack_cooldown_time
		
func _physics_process(delta):
	var x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
	if x_input != 0:
		if !attack_playing:
			if lantern_held:
				sprite.play("run_lantern")
			else:
				sprite.play("run")
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0
	else:
		if !attack_playing:
			if lantern_held:
				sprite.play("idle_lantern")
			else:
				sprite.play("idle")

	motion.y += GRAVITY * delta
	
	if is_on_floor():
		jumps_left = 2
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
			
		if Input.is_action_just_pressed("up"):
			motion.y = -JUMP_FORCE
			jumps_left -= 1
	else: 
		if next_to_wall():
			if Input.is_action_just_pressed("up") and jumps_left > 0:
				jumps_left -= 1
				motion.y = -JUMP_FORCE/2
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

func hit():
	print("hit received")
	life -= 1
	
	if life <= 0:
		get_tree().reload_current_scene()


func _on_AnimatedSprite_animation_finished():
	attack_playing = false;
	sprite.stop()
	
func is_hitting_enemy():
	print("attacking")
