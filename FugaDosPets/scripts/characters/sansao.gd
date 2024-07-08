extends CharacterBody2D


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var SPEED: int = 1000

var returning: bool = false
var monica_pos: Vector2
var target_pos: Vector2

const TARGET_OFFSET: int = 5


func _ready() -> void:
	global_position = monica_pos


func _physics_process(_delta: float) -> void:
	if not audio_stream_player_2d.playing:
		audio_stream_player_2d.play()
	
	if position.distance_to(target_pos) < TARGET_OFFSET:
		move_back()
	
	if returning and position.distance_to(monica_pos) < TARGET_OFFSET:
		queue_free()
	
	move_and_slide()
	for i in get_slide_collision_count():
		var collision: KinematicCollision2D = get_slide_collision(i)
		_on_area_2d_body_entered(collision.get_collider())


func move(origin: Vector2, target: Vector2) -> void:
	monica_pos = origin
	target_pos = target
	var direction: = (target - origin).normalized()
	rotation = direction.angle()
	velocity = Vector2(SPEED, 0).rotated(rotation)


func move_back() -> void:
	returning = true
	target_pos = monica_pos
	var direction: = (monica_pos - position).normalized()
	rotation = direction.angle()
	velocity = Vector2(SPEED, 0).rotated(rotation)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if String(body.name).begins_with("Lever") \
		and body.has_method("pull"):
		body.pull()
	move_back()


func _on_timer_timeout() -> void:
	queue_free()
