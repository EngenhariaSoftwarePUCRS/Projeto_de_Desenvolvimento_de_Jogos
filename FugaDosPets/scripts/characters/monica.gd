extends CharacterBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var sansao = load("res://scenes/sansao.tscn")

const SPEED = 300.0 / 1.5
const JUMP_VELOCITY = -400.0 / 2

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	animated_sprite.play("idle")


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

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	get_tree().call_group("level1", "update_player_position", position.x, position.y)
	
	animate()
	move_and_slide()


func animate() -> void:
	if velocity.x == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("walking")
	animated_sprite.flip_h = velocity.x < 0


func throw_sansao() -> void:
	var sansao_i = sansao.instantiate()
	var mouse_position = get_global_mouse_position()
	sansao_i.move(global_position, mouse_position)
	get_tree().call_group("level1", "spawn_sansao", sansao_i)
