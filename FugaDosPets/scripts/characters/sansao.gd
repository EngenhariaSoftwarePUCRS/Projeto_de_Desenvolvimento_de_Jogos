extends CharacterBody2D


@export var SPEED = 1000

const TARGET_OFFSET: int = 5
var returning = false
var monica_pos: Vector2
var target_pos: Vector2


func _ready() -> void:
	global_position = monica_pos


func _physics_process(delta: float) -> void:
	if position.distance_to(target_pos) < TARGET_OFFSET:
		move_back()
	
	if returning and position.distance_to(monica_pos) < TARGET_OFFSET:
		queue_free()
	
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
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


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	if not body.visible:
		return
	if String(body.name).begins_with("Lever") \
		and body.has_method("pull"):
		body.pull()
	move_back()


func _on_timer_timeout():
	queue_free()
