extends Node2D


@onready var character_selection: CanvasLayer = $CharacterSelection
@onready var monica: CharacterBody2D = $Monica
@onready var cebolinha: CharacterBody2D = $Cebolinha
@onready var cascao: CharacterBody2D = $Cascao
@onready var magali: CharacterBody2D = $Magali

var active_character: CharacterBody2D


func _ready() -> void:
	character_selection.visible = false
	reset_characters()


func _process(_delta: float) -> void:
	if Input.is_action_pressed("change_characters"):
		character_selection.visible = true
	else:
		character_selection.visible = false


func reset_characters() -> void:
	monica.visible = false
	cebolinha.visible = false
	cascao.visible = false
	magali.visible = false


func change_character(new_character_name: String) -> void:
	if not has_node(new_character_name):
		print("Personagem '", new_character_name, "' indisponível ou inexistente.")
		return
	var new_active_character: CharacterBody2D = get_node(new_character_name)
	if new_active_character == active_character:
		return
	reset_characters()
	if not active_character:
		active_character = new_active_character
	new_active_character.position = active_character.position
	new_active_character.visible = true
	active_character = new_active_character
