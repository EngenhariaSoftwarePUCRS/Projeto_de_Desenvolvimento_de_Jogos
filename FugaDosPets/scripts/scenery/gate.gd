extends StaticBody2D


@export var opened: bool
@onready var closed_sprite = $ClosedSprite
@onready var opened_sprite = $OpenedSprite
@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D


func _ready() -> void:
	opened = false
	closed_sprite.visible = false


func open() -> void:
	if opened:
		return
	audio_stream_player_2d.play()
	opened = true
	closed_sprite.visible = true
	opened_sprite.visible = false
	collider.set_deferred("disabled", true)
