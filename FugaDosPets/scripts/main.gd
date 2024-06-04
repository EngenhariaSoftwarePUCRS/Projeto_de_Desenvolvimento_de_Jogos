extends Node


@onready var settings_layer: CanvasLayer = $SettingsLayer


func show_settings() -> void:
	settings_layer.visible = true


func on_level_selected(level: int) -> void:
	print(level)
