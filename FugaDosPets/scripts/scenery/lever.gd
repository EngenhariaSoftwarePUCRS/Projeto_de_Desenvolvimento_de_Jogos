extends Node2D


@export var pulled: bool

@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	pulled = false


func pull(callable: Callable) -> void:
	if not pulled:
		pulled = true
		callable.call()
