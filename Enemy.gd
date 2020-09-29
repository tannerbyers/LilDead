extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30
const UP = Vector2(0,-1)

onready var playerNode =  get_node("../Player")
onready var attackTimer = $AttackTimer
var attackReady = true
var health = 3

var velocity = Vector2.ZERO
onready var leftRaycast = $LeftRayCast
onready var rightRaycast = $RightRayCast
onready var topRaycast = $TopRayCast
var direction = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.x = SPEED * direction
	velocity.y += GRAVITY

	velocity = move_and_slide(velocity, UP)
	
	if leftRaycast.is_colliding():
		var coll = leftRaycast.get_collider()
		if coll.name == "Player" and attackReady:
			print("hit")
			attackReady = false
			attackTimer.start()
			coll.hit()
			
	if rightRaycast.is_colliding():
		var coll = rightRaycast.get_collider()
		if coll.name == "Player" and attackReady:
			$AnimatedSprite.play("attack")
			attackReady = false
			attackTimer.start()
			coll.hit()
	elif topRaycast.is_colliding():
		var coll = topRaycast.get_collider()
		if coll.name == "Player" and attackReady:
			$AnimatedSprite.play("attack")
			attackReady = false
			attackTimer.start()
			coll.hit()
	else:
		if attackReady:
			$AnimatedSprite.play("walking")
		else:
			pass
			
	if is_on_wall():
		direction = direction * -1
		$AnimatedSprite.flip_h = direction > 0

func hit(damage):
	health -= 1
	if health <= 0:
		queue_free()
		
func _on_AttackTimer_timeout():
	attackReady = true
