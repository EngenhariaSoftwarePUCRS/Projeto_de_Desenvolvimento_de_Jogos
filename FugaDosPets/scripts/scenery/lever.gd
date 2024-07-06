extends Node2D


@export var pulled: bool

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collider: CollisionShape2D = $CollisionShape2D

var pull_action: Callable


func _ready() -> void:
	pulled = false


func on_pull(callable: Callable) -> void:
	pull_action = callable


func pull() -> void:
	assert(pull_action != null, "Error: You must set on_pull(callback) function before attempting to pull the lever")
	if pulled:
		return
	pulled = true
	collider.disabled = true
	pull_action.call()
