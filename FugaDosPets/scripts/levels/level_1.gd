extends Node


@onready var character: CharacterBody2D = $Character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Loaded Level 1")
