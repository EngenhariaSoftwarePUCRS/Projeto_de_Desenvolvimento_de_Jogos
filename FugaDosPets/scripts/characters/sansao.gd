extends CharacterBody2D


@export var SPEED = 200

var goal
var returning = false
var monica


func _ready() -> void:
	visible = false
	monica = get_parent()
	velocity = Vector2.ZERO


func _physics_process(delta: float) -> void:
	if not visible:
		return
	
	if position.distance_to(goal) < 2:
		print("reached")
		returning = true
		move_back()
	
	if returning and position.distance_to(monica.position) < 0:
		visible = false
	
	move_and_slide()


func move(target) -> void:
	goal = target
	velocity = position.direction_to(target) * SPEED


func move_back() -> void:
	velocity = position.direction_to(monica.position) * SPEED
