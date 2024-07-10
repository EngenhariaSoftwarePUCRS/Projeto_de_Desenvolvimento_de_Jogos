extends AnimatableBody2D


@export var pulled: bool

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var collider: CollisionShape2D = $Collider
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

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
	sprite.play("pull")
	audio_stream_player_2d.play()
	collider.set_deferred("disabled", true)
	pull_action.call()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	pull()
