extends KinematicBody2D

const MOVE_SPEED = 2 # 100px per sec 

var lantern_held = false

func _process(delta):
	$AnimatedSprite.visible = lantern_held
	$Light2D.visible = lantern_held
	$Particles2D.visible = lantern_held
	
	var vec_to_mouse = get_global_mouse_position() - global_position
	move_and_collide(vec_to_mouse * MOVE_SPEED * delta)
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
	
