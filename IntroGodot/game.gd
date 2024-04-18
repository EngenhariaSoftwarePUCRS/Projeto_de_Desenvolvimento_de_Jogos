extends Node2D

@onready var player : CharacterBody2D = $MainCharacter
@onready var hud : CanvasLayer = $HUD

var gameScore : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Jogo Começou!")
	print("Pos: " + str(player.position))
	#player.connect("jumped", _on_jumped)

func updateScore():
	gameScore += 1
	hud.updateScore(gameScore)

func _on_jumped():
	updateScore()
