extends StaticBody2D

var pressurePadPressed = false

func _ready():
	print("door loaded")
	$AnimatedSprite.play("load")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func pressurePadStepped (): 
	print("pressurepad stepped")
	pressurePadPressed = true
	$AnimatedSprite.play("default")


func _on_AnimatedSprite_animation_finished():
	if pressurePadPressed:
		print("closing door")
		$CollisionShape2D.disabled = pressurePadPressed
		$AnimatedSprite.play("closed")
		$AnimatedSprite.stop()
	else:
		print("animation finished")
		$AnimatedSprite.play("load")
		$AnimatedSprite.stop()
		$CollisionShape2D.disabled = false
	

func timesUp():
	pressurePadPressed = false
	$AnimatedSprite.play("default", true)
