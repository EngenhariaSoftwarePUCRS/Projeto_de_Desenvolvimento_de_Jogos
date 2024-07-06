extends Node2D

@export var offset: Vector2 = Vector2(0, -320)
@export var duration: float = 5.0

@onready var animatable_body_2d: AnimatableBody2D = $AnimatableBody2D

func _ready() -> void:
	start_tween()

func start_tween() -> void:
	var tween: Tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops().set_parallel(false)
	tween.tween_property(animatable_body_2d, "position", offset, duration / 2)
	tween.tween_property(animatable_body_2d, "position", Vector2.ZERO, duration / 2)
