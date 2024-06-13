extends CharacterBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite


const SPEED = 300.0 * 1.1
const JUMP_VELOCITY = -400.0 / 4

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity") / 4


func _ready() -> void:
	animated_sprite.play("idle")


func animate() -> void:
	if velocity.x == 0:
		animated_sprite.play("idle")
	else:
		pass
		# animated_sprite.play("walking")
	animated_sprite.flip_h = velocity.x < 0


func _physics_process(delta: float) -> void:
	if visible == false:
		return
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# print("Cascão", position)
	get_tree().call_group("level1", "update_player_position", position.x, position.y)
	
	animate()
	move_and_slide()
