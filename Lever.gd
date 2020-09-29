extends Area2D

func _ready():
	$AnimatedSprite.play("switch")
	
func flip_switch():
	$AnimatedSprite.play("on")

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
