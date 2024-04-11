extends CharacterBody2D

@export var speed: int = 400
@onready var _animated_sprite = $AnimatedSprite

const directions = ["move_left", "move_right", "move_up", "move_down"]
const LEFT = directions[0]
const RIGHT = directions[1]
const UP = directions[2]
const DOWN = directions[3]

func get_8way_input() -> void:
	var input_direction: Vector2 = Input.get_vector(LEFT, RIGHT, UP, DOWN)
	velocity = input_direction * speed
	#print(velocity)

func _physics_process(delta) -> void:
	#1. 8 Way movement
	get_8way_input()
	move_and_slide()

func _process(delta) -> void:
	for direction in directions:
		if Input.is_action_pressed(direction):
			_animated_sprite.play(direction)
		else:
			_animated_sprite.stop()
