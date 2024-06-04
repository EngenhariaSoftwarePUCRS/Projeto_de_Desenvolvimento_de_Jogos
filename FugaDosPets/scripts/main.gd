extends Node


@onready var settings_layer: CanvasLayer = $SettingsLayer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_settings"):
		show_settings()


func show_settings() -> void:
	settings_layer.visible = true


func _replace_last_node(new_scene_res) -> void:
	var scene_exists: bool = ResourceLoader.exists(new_scene_res)
	if not scene_exists:
		print("Scene Not Found")
		return
	var last_node_index: int = get_child_count() - 1
	var last_node = get_child(last_node_index)
	last_node.free()
	var new_scene = ResourceLoader.load(new_scene_res)
	new_scene = new_scene.instantiate()
	add_child(new_scene)


func return_to_home() -> void:
	var home_res := "res://scenes/initial.tscn"
	_replace_last_node(home_res)


func on_level_selected(level: int) -> void:
	var level_res := str("res://scenes/levels/level_", level, ".tscn")
	_replace_last_node(level_res)
