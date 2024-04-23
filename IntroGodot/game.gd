extends Node2D

@onready var player : CharacterBody2D = $Level/MainCharacter
@onready var sceneLimit : Marker2D = $Level/SceneLimit
@onready var hud : CanvasLayer = $HUD

var gameScore : int = 0
var currentScene = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Jogo Começou!")
	print("Pos: " + str(player.position))
	#player.connect("jumped", _on_jumped)

func _physics_process(delta: float) -> void:
	if sceneLimit == null:
		player = $Level/MainCharacter
		sceneLimit = $Level/SceneLimit
	if player.position.y > sceneLimit.position.y:
		get_tree().change_scene_to_file("res://game_over.tscn")
	if Input.is_action_just_pressed("change"):
		call_deferred("goto_scene", "res://level2.tscn")

func updateScore():
	gameScore += 1
	hud.setScore(gameScore)

func _on_jumped():
	updateScore()

func goto_scene(path: String):
		print("Total children: " + str(get_child_count))
		var world := get_child(1)
		world.free()
		var res := ResourceLoader.load(path)
		currentScene = res.instantiate()
		sceneLimit = null
		add_child(currentScene)
