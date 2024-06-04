extends Control

@onready var button: Button = $Button

@export var text = 'ChangeMe'


func _ready() -> void:
	button.text = text


func _on_button_pressed() -> void:
	get_tree().call_group("main", "on_level_selected", int(text))
