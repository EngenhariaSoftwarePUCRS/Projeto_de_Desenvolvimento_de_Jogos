extends RigidBody2D


@export var SPEED: int = 200

var magali_pos: Vector2


func _ready() -> void:
	global_position = magali_pos


func move(origin: Vector2) -> void:
	magali_pos = origin


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body.visible:
		return
	if String(body.name).begins_with("Lever") \
		and body.has_method("pull"):
		body.pull()


func _on_timer_timeout() -> void:
	queue_free()
