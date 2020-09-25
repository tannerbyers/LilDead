extends Area2D

onready var playerNode =  get_node("../Player")
onready var ghostNode =  get_node("../Ghost")

func _on_Area2D_body_entered(body):
	if (body is KinematicBody2D):
		playerNode.lantern_held = true
		ghostNode.lantern_held = true
		print("lantern colidded by player")
		$AnimatedSprite.visible = false
