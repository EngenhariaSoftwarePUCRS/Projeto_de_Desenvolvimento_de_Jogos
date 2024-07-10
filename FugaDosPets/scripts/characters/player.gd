extends Node2D


@onready var character_selection: CanvasLayer = $CharacterSelection
@onready var audio_listener_2d: AudioListener2D = $AudioListener2D
@onready var monica: CharacterBody2D = $Monica
@onready var cebolinha: CharacterBody2D = $Cebolinha
@onready var cascao: CharacterBody2D = $Cascao
@onready var magali: CharacterBody2D = $Magali

var active_character: CharacterBody2D
var sceneLimit: Vector2


func _ready() -> void:
	character_selection.visible = true
	reset_characters()


func _process(_delta: float) -> void:
	assert(sceneLimit != Vector2.ZERO, "Must set sceneLimit for Player")
	if active_character.position.y > sceneLimit.y:
		get_tree().call_group("main", "player_fell")
	if active_character.position.x > sceneLimit.x:
		get_tree().call_group("main", "player_passed_level")
	audio_listener_2d.position = active_character.position


func reset_characters() -> void:
	monica.go_intangible()
	cebolinha.go_intangible()
	cascao.go_intangible()
	magali.go_intangible()


func change_character(new_character_name: String) -> void:
	assert(has_node(new_character_name),
		str("Personagem '", new_character_name, "' indisponível ou inexistente."))
	var new_active_character: CharacterBody2D = get_node(new_character_name)
	if new_active_character == active_character:
		return
	reset_characters()
	if not active_character:
		active_character = new_active_character
	new_active_character.position = active_character.position
	new_active_character.go_tangible()
	active_character = new_active_character
