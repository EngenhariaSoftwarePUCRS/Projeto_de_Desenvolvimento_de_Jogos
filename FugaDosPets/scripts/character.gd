extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func reset_character() -> void:
	SPEED = 300
	JUMP_VELOCITY = -500
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func change_character(new_character: String) -> void:
	reset_character()
	match new_character:
		'franjinha':
			pass
		'monica':
			SPEED = 200
		'cebolinha':
			JUMP_VELOCITY = -1200
		"cascao":
			gravity = 490
		"magali":
			SPEED = 150
			gravity = 1000
