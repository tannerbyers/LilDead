extends KinematicBody2D

onready var playerNode =  get_node("../Player")
onready var leverNode =  get_node("../Lever")

const MOVE_SPEED = 2

var lantern_held = false

func _process(delta):
	$AnimatedSprite.visible = lantern_held
	$Light2D.visible = lantern_held
	$Particles2D.visible = lantern_held
	$CollisionShape2D.disabled = !lantern_held
	
	var vec_to_mouse = get_global_mouse_position() - global_position
	
	move_and_slide(vec_to_mouse * MOVE_SPEED)
	
	if lantern_held:	
		var mpos = get_global_mouse_position()
		var pos = global_position
		
		if vec_to_mouse.x < 0:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
			
		if vec_to_mouse.x > 1:
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.play("idle")
			
			
		look_at(get_global_mouse_position())
		var rot = rad2deg((mpos - pos).angle())
		if(rot >= -90 and rot <= 90):
			$AnimatedSprite.flip_v = false	
		else:
			$AnimatedSprite.flip_v = true
	else: 
		pass


func _on_Lever_body_entered(body):
	print(leverNode)
	leverNode.flip_switch()
