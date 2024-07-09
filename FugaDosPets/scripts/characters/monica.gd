extends CharacterBody2D


@export var SPEED: float = 300.0
@export var JUMP_VELOCITY: float = -400.0 / 1.5

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var right_collider: CollisionPolygon2D = $RightCollider
@onready var left_collider: CollisionPolygon2D = $LeftCollider
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sansao: Resource = load("res://scenes/characters/sansao.tscn")

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	animated_sprite.play("idle")
	enable_right_collider()


func _input(event: InputEvent) -> void:
	if visible == false:
		return
	
	if event.is_action_pressed("action"):
		throw_sansao()


func _physics_process(delta: float) -> void:
	if visible == false:
		return
	
	if not is_on_floor():
		velocity.y += gravity * delta
		audio_stream_player_2d.stop()

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction: float = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x != 0:
		if not audio_stream_player_2d.playing:
			audio_stream_player_2d.play()
	else:
		audio_stream_player_2d.stop()
	
	animate()
	move_and_slide()


func go_intangible() -> void:
	visible = false
	right_collider.set_deferred("disabled", true)
	left_collider.set_deferred("disabled", true)


func go_tangible() -> void:
	visible = true
	if animated_sprite.flip_h:
		enable_left_collider()
	else:
		enable_right_collider()


func enable_left_collider() -> void:
	right_collider.set_deferred("disabled", true)
	left_collider.set_deferred("disabled", false)


func enable_right_collider() -> void:
	left_collider.set_deferred("disabled", true)
	right_collider.set_deferred("disabled", false)


func animate() -> void:
	if velocity.x == 0:
		animated_sprite.play("idle")
		return
	#animated_sprite.play("walking")
	if velocity.x > 0:
		animated_sprite.flip_h = false
		enable_right_collider()
	elif velocity.x < 0:
		animated_sprite.flip_h = true
		enable_left_collider()


func throw_sansao() -> void:
	var sansao_i: Node = sansao.instantiate()
	var mouse_position: Vector2 = get_global_mouse_position()
	sansao_i.move(global_position, mouse_position)
	get_tree().call_group("main", "spawn_object_on_level", sansao_i)
