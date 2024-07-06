extends AnimatableBody2D


@export var OFFSET: Vector2 = Vector2(0, -320)
@export var DURATION: float = 5.0

var initial_position: Vector2


func _ready() -> void:
	initial_position = position
	start_movement()


func start_movement() -> void:
	var tween: Tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property(self, "position", initial_position + OFFSET, DURATION / 2)
	tween.tween_property(self, "position", initial_position, DURATION / 2)
