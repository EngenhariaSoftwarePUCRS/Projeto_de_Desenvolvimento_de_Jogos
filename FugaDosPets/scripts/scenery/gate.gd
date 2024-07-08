extends StaticBody2D


@export var opened: bool
@onready var closed_sprite = $ClosedSprite
@onready var opened_sprite = $OpenedSprite
@onready var collider: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	opened = false
	closed_sprite.visible = false


func open() -> void:
	if opened:
		return
	opened = true
	closed_sprite.visible = true
	opened_sprite.visible = false
	collider.set_deferred("disabled", true)
