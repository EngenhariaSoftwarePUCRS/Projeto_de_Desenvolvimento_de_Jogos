extends Node2D

@onready var player : CharacterBody2D = $Level/MainCharacter
@onready var sceneLimit : Marker2D = $Level/SceneLimit
@onready var hud : CanvasLayer = $HUD

var gameScore : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Jogo Começou!")
	print("Pos: " + str(player.position))
	#player.connect("jumped", _on_jumped)

func _physics_process(delta: float) -> void:
	if player.position.y < sceneLimit.position.y:
		get_tree().change_scene_to_file("res://game_over.tscn")

func updateScore():
	gameScore += 1
	hud.setScore(gameScore)

func _on_jumped():
	updateScore()
