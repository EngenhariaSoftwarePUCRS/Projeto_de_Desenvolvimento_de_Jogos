extends CharacterBody2D

@export var speed: int = 300
@export var jump_speed: int = -1000
@export var gravity: int = 2500
@export var rotation_speed: float = 1.5
@onready var _animated_sprite = $AnimatedSprite

const directions = ["move_left", "move_right", "move_up", "move_down"]
const LEFT = directions[0]
const RIGHT = directions[1]
const UP = directions[2]
const DOWN = directions[3]
const MOUSE_CLICK = "mouse_click"

var rotation_direction: float = 0
var target = position

func get_8way_input() -> void:
	var input_direction: Vector2 = Input.get_vector(LEFT, RIGHT, UP, DOWN)
	velocity = input_direction * speed
	#print(velocity)

func get_rotation_input() -> void:
	rotation_direction = Input.get_axis(LEFT, RIGHT)
	var move_direction = Input.get_axis(DOWN, UP)
	velocity = transform.x * move_direction  * speed
	#print(transform.x)

func get_mouse_input() -> void:
	look_at(get_global_mouse_position())
	#print(rotation_degrees)
	#print(transform)
	var move_direction = Input.get_axis(DOWN, UP)
	velocity = transform.x * move_direction * speed

func get_mouse_click() -> void:
	if Input.is_action_pressed(MOUSE_CLICK):
		target = get_global_mouse_position()

func get_sideways_input() -> void:
	velocity.x = 0
	var vel := Input.get_axis(LEFT, RIGHT)
	var jump := Input.is_action_pressed(UP)
	
	if is_on_floor() and jump:
		velocity.y = jump_speed
	velocity.x = vel * speed

func animate_top_down():
	if velocity.x > 0:
		_animated_sprite.play(RIGHT)
	elif velocity.x < 0:
		_animated_sprite.play(LEFT)
	elif velocity.y > 0:
		_animated_sprite.play(DOWN)
	elif velocity.y < 0:
		_animated_sprite.play(UP)
	else:
		_animated_sprite.stop()

func animate_sideways():
	if velocity.x > 0:
		_animated_sprite.play(RIGHT)
	elif velocity.x < 0:
		_animated_sprite.play(LEFT)
	else:
		_animated_sprite.stop()

func _physics_process(delta) -> void:
	#1. 8 Way movement
	#get_8way_input()
	#animate_top_down()
	#move_and_slide()
	
	#1.5 8 Way movement with stop
	#get_8way_input()
	#animate_top_down()
	#var collision_info := move_and_collide(velocity * delta)
	#if collision_info:
	#	print(collision_info.get_angle())
	#	print(collision_info.get_collider().to_string())
	#	print(collision_info.get_normal())
	#	print(collision_info.get_position())
	#	velocity = velocity.bounce(collision_info.get_normal())
	#	move_and_collide(velocity * delta * 50)
	#move_and_slide()

	#2. Rotate, then move
	#get_rotation_input()
	#rotation += rotation_direction * rotation_speed * delta
	#animate_top_down()
	#move_and_slide()

	#3. Aim with mouse, then move
	#get_mouse_input()
	#if position.distance_to(target) > 10:
	#	animate_top_down()
	#	move_and_slide()

	#4. Mouse click moves
	#get_mouse_click()
	#velocity = position.direction_to(target) * speed
	#if position.distance_to(target) > 10:
	#	animate_top_down()
	#	move_and_slide()
	
	#5. Sideways movement
	velocity.y += gravity * delta
	get_sideways_input()
	animate_sideways()
	move_and_slide()
