extends CharacterBody2D


@export var SPEED = 200

var returning = false
var goal
var monica


func _ready() -> void:
	visible = false
	velocity = Vector2.ZERO
	top_level = true


func _physics_process(delta: float) -> void:
	if not visible:
		return
	
	print()
	print(0, " ", velocity)
	print(1.2, " ", position.x, " | ", position.y)
	print(1.4, " ", goal.x, " | ", goal[1])
	
	print(1, " ", position.distance_to(goal))
	if position.distance_to(goal) < 2:
		returning = true
		move_back()
	
	print(2, " ", position.distance_to(monica.position))
	if returning and position.distance_to(monica.position) < 4:
		visible = false
	
	velocity = (goal - position).normalized() * SPEED * delta
	move_and_slide()


func move(target) -> void:
	if not visible:
		visible = true
	monica = get_parent()
	position = monica.position
	goal = target
	velocity = (goal - position).normalized() * SPEED


func move_back() -> void:
	goal = monica.position
	velocity = (goal - position).normalized() * SPEED
