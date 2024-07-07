extends Node2D


@onready var character_selection: CanvasLayer = $CharacterSelection
@onready var monica: CharacterBody2D = $Monica
@onready var cebolinha: CharacterBody2D = $Cebolinha
@onready var cascao: CharacterBody2D = $Cascao
@onready var magali: CharacterBody2D = $Magali


func _ready() -> void:
	character_selection.visible = false
	reset_characters()


func _input(event: InputEvent) -> void:
	const characters: Array[String] = ["franjinha", "monica", "cebolinha", "cascao", "magali"]
	for character in characters:
		if event.is_action_pressed("change_character_to_" + character):
			change_character(character)


func _process(delta: float) -> void:
	if Input.is_action_pressed("change_characters"):
		character_selection.visible = true
	else:
		character_selection.visible = false


func reset_characters() -> void:
	monica.visible = false
	cebolinha.visible = false
	cascao.visible = false
	magali.visible = false


func change_character(	new_character: String) -> void:
	reset_characters()
	print(str("Changing to ", new_character))
	match new_character:
		'franjinha':
			pass
		'monica':
			monica.visible = true
			monica.position = position
		'cebolinha':
			cebolinha.visible = true
			cebolinha.position = position
		"cascao":
			cascao.visible = true
			cascao.position = position
		"magali":
			magali.visible = true
			magali.position = position
