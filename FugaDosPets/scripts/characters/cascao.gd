extends CharacterBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var right_collider: CollisionPolygon2D = $RightCollider
@onready var left_collider: CollisionPolygon2D = $LeftCollider


const SPEED = 300.0 * 1.2
const JUMP_VELOCITY = -400.0 / 3

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	animated_sprite.play("idle")
	enable_right_collider()


func _physics_process(delta: float) -> void:
	if visible == false:
		return
	
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction: float = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# print("Cascão", position)
	get_tree().call_group("level1", "update_player_position", position.x, position.y)
	
	animate()
	move_and_slide()


func enable_left_collider() -> void:
	right_collider.disabled = true
	left_collider.disabled = false


func enable_right_collider() -> void:
	left_collider.disabled = true
	right_collider.disabled = false


func animate() -> void:
	if velocity.y > 0:
		animated_sprite.play("gliding")
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity") / 8
	elif velocity.x == 0:
		animated_sprite.play("idle")
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity") / 4
		return
	# animated_sprite.play("walking")
	if velocity.x > 0:
		animated_sprite.flip_h = false
		enable_right_collider()
	elif velocity.x < 0:
		animated_sprite.flip_h = true
		enable_left_collider()
