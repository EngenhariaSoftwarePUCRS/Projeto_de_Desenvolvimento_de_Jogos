extends Node


@onready var player: Node2D = $Player
@onready var scene_limit: Marker2D = $SceneLimit


func _ready() -> void:
	player.sceneLimit = Vector2(scene_limit.position.x, scene_limit.position.y)
	player.change_character("Monica")
