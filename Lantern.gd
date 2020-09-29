extends Area2D

onready var playerNode =  get_node("../Player")
onready var kisumeNode =  get_node("../Kisume")

func _on_Area2D_body_entered(body):
	if (body is KinematicBody2D):
		playerNode.lantern_held = true
		kisumeNode.lantern_held = true
		$AnimatedSprite.visible = false
		$Light2D.visible = false
