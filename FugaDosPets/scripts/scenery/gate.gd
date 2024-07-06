extends StaticBody2D


@export var opened: bool

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collider: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	opened = false


func open() -> void:
	if opened:
		return
	opened = true
	collider.set_deferred("disabled", true)
