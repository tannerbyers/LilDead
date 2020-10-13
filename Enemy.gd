extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30
const UP = Vector2(0,-1)

onready var playerNode =  get_node("../Player")
var isAttacking = false
var health = 3
var playerSeen = false

var velocity = Vector2.ZERO
onready var leftRaycast = $LeftRayCast
onready var rightRaycast = $RightRayCast
onready var topRaycast = $TopRayCast
var direction = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if leftRaycast.is_colliding():
		var leftcoll = leftRaycast.get_collider()
		if leftcoll:
			if leftcoll.name == "Player":
				print("attacking player")
				isAttacking = true
				$AnimatedSprite.play("attack")
				$AttackArea/AttackCollision.disabled = false
				$AttackArea/AttackCollision2.disabled = false
			else:
				direction = direction * -1
				$AnimatedSprite.flip_h = direction > 0
	elif rightRaycast.is_colliding():
		var rightcoll = rightRaycast.get_collider()
		if rightcoll:
			if rightcoll.name == "Player":
				print("attacking player")
				isAttacking = true
				$AnimatedSprite.play("attack")
				$AttackArea/AttackCollision.disabled = false
				$AttackArea/AttackCollision2.disabled = false
			else:
				direction = direction * -1
				$AnimatedSprite.flip_h = direction > 0
	else:
		if !isAttacking:
			$AnimatedSprite.play("walking")
	
	if playerSeen:
		velocity = position.direction_to(playerNode.position) * SPEED * 2
		$AnimatedSprite.flip_h = velocity.x >= 0
			
	else: 
		velocity.x = SPEED * direction
		velocity.y += GRAVITY	
		$AnimatedSprite.flip_h = velocity.x >= 0
	velocity = move_and_slide(velocity, UP)

func hit(damage):
	health -= 1
	if health <= 0:
		queue_free()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "attack":
		$AttackArea/AttackCollision.disabled = true
		$AttackArea/AttackCollision2.disabled = true
		isAttacking = false


func _on_AttackArea_body_entered(body):
	if body.is_in_group("player"):
		playerNode.hit()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		playerSeen = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		playerSeen = false
