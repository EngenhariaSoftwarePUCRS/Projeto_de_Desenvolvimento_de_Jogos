extends CharacterBody2D


@export var SPEED: float = 300.0
@export var JUMP_VELOCITY: float = -400.0 * 2

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var right_collider: CollisionPolygon2D = $RightCollider
@onready var left_collider: CollisionPolygon2D = $LeftCollider

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
	
	animate()
	move_and_slide()


func go_intangible() -> void:
	visible = false
	right_collider.disabled = true
	left_collider.disabled = true


func go_tangible() -> void:
	visible = true
	if animated_sprite.flip_h:
		enable_left_collider()
	else:
		enable_right_collider()


func enable_left_collider() -> void:
	right_collider.disabled = true
	left_collider.disabled = false


func enable_right_collider() -> void:
	left_collider.disabled = true
	right_collider.disabled = false


func animate() -> void:
	if velocity.x == 0:
		animated_sprite.play("idle")
		return
	# animated_sprite.play("walking")
	if velocity.x > 0:
		animated_sprite.flip_h = false
		enable_right_collider()
	elif velocity.x < 0:
		animated_sprite.flip_h = true
		enable_left_collider()
