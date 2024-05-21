extends Control

@onready var settings_layer: CanvasLayer = $SettingsLayer
@onready var level_selection: CanvasLayer = $LevelSelection
@onready var play_button: Button = $Play


func _on_settings_pressed():
	settings_layer.visible = true


func _on_play_pressed() -> void:
	play_button.queue_free()
	level_selection.visible = true
