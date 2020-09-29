extends Area2D

onready var doorNode =  get_node("../")

func _on_PressurePad_body_entered(body):
	if body.is_in_group("player"):
		doorNode.pressurePadStepped()
		$Timer.start()
		$AnimatedSprite.play("stepped")
		print("player hit pressurepad")


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()


func _on_Timer_timeout():
	print("timeout")
	doorNode.timesUp()
