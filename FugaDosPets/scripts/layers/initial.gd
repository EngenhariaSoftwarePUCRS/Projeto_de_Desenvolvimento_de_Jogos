extends Control

@onready var level_selection: CanvasLayer = $LevelSelection
@onready var play_button: Button = $Play


func _on_settings_pressed() -> void:
	get_tree().call_group("main", "show_settings")


func _on_play_pressed() -> void:
	play_button.queue_free()
	level_selection.visible = true
	get_tree().call_group("main", "mouse_show")


func _on_exit_pressed() -> void:
	get_tree().quit()
