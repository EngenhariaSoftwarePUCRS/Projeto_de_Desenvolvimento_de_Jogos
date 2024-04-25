extends Node2D

@onready var player : CharacterBody2D = $Level/MainCharacter
@onready var sceneLimit : Marker2D = $Level/SceneLimit
@onready var hud : CanvasLayer = $HUD

var gameScore : int = 0
var currentScene = null
var lowpass : AudioEffectLowPassFilter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Jogo Começou!")
	print("Pos: " + str(player.position))
	#player.connect("jumped", _on_jumped)
	$Music.play()
	var master: int = AudioServer.get_bus_index("Master")
	var music: int = AudioServer.get_bus_index("Music")
	var sfx: int = AudioServer.get_bus_index("SFX")
	lowpass = AudioServer.get_bus_effect(music, 0) as AudioEffectLowPassFilter

func toggle_lowpass():
	if lowpass.cutoff_hz == 2000:
		lowpass.cutoff_hz = 500
	else:
		lowpass.cutoff_hz = 2000

func _physics_process(delta: float) -> void:
	if sceneLimit == null:
		player = $Level/MainCharacter
		sceneLimit = $Level/SceneLimit
	if player.position.y > sceneLimit.position.y:
		get_tree().change_scene_to_file("res://game_over.tscn")
	if Input.is_action_just_pressed("change"):
		call_deferred("goto_scene", "res://level2.tscn")
	if Input.is_action_just_pressed("lowpass"):
		toggle_lowpass()

func updateScore():
	gameScore += 1
	hud.setScore(gameScore)

func _on_jumped():
	updateScore()

func goto_scene(path: String):
		print("Total children: " + str(get_child_count))
		var world := get_child(2)
		world.free()
		var res := ResourceLoader.load(path)
		currentScene = res.instantiate()
		sceneLimit = null
		add_child(currentScene)
