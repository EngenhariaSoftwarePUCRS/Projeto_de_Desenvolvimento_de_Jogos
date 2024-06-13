extends Node2D


@onready var monica: CharacterBody2D = $Monica
@onready var cebolinha: CharacterBody2D = $Cebolinha
@onready var cascao: CharacterBody2D = $Cascao
@onready var magali: CharacterBody2D = $Magali


func _ready() -> void:
	reset_characters()
	monica.visible = true


func reset_characters() -> void:
	monica.visible = false
	cebolinha.visible = false
	cascao.visible = false
	magali.visible = false


func change_character(new_character: String, pos_x: int, pos_y: int) -> void:
	reset_characters()
	match new_character:
		'franjinha':
			pass
		'monica':
			monica.visible = true
			monica.position.x = pos_x
			monica.position.y = pos_y
		'cebolinha':
			cebolinha.visible = true
			cebolinha.position.x = pos_x
			cebolinha.position.y = pos_y
		"cascao":
			cascao.visible = true
			cascao.position.x = pos_x
			cascao.position.y = pos_y
		"magali":
			magali.visible = true
			magali.position.x = pos_x
			magali.position.y = pos_y
