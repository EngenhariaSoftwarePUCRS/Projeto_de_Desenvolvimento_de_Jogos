extends CharacterBody2D

@export var speed: int = 400
@onready var _animated_sprite = $AnimatedSprite

const directions = ["left", "right", "up", "down"]

func get_input() -> void:
	const LEFT = "move_" + directions[0]
	const RIGHT = "move_" + directions[1]
	const UP = "move_" + directions[2]
	const DOWN = "move_" + directions[3]
	var input_direction: Vector2 = Input.get_vector(LEFT, RIGHT, UP, DOWN)
	velocity = input_direction * speed

func _physics_process(delta) -> void:
	get_input()
	move_and_slide()

func _process(delta) -> void:
	var move: String
	var previousMove: String
	for direction in directions:
		move = "move_" + direction
		if move != previousMove:
			previousMove = move
			if Input.is_action_pressed(move):
				_animated_sprite.play(move)
			else:
				_animated_sprite.stop()
