extends CharacterBody2D


@export var SPEED = 1000

var returning = false
var monica_pos: Vector2
var target_pos: Vector2


func _ready() -> void:
	global_position = monica_pos


func _physics_process(delta: float) -> void:
	if position.distance_to(target_pos) < 50:
		returning = true
		move_back()
	
	if returning and position.distance_to(monica_pos) < 50:
		queue_free()
	
	move_and_slide()


func move(origin: Vector2, target: Vector2) -> void:
	monica_pos = origin
	target_pos = target
	var direction: = (target - origin).normalized()
	rotation = direction.angle()
	velocity = Vector2(SPEED, 0).rotated(rotation)


func move_back() -> void:
	target_pos = monica_pos
	var direction: = (monica_pos - position).normalized()
	rotation = direction.angle()
	velocity = Vector2(SPEED, 0).rotated(rotation)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
