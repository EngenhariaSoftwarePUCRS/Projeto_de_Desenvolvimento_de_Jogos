extends Control

@onready var button: Button = $Button

@export var value: String = 'ChangeMe'
@export var disabled: bool = false


func _ready() -> void:
	button.text = value
	button.disabled = disabled


func _on_button_pressed() -> void:
	var level = int(value)
	get_tree().call_group("main", "on_level_selected", level)
