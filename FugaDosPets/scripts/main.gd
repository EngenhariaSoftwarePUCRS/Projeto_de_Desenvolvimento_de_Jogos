extends Node


@onready var settings_layer: CanvasLayer = $SettingsLayer

var current_level_number: int


func _ready() -> void:
	settings_layer.visible = false


func _input(event: InputEvent) -> void:	
	if event.is_action_pressed("open_settings"):
		show_settings()


func show_settings() -> void:
	# get_tree().paused = true
	settings_layer.visible = true


func close_settings() -> void:
	settings_layer.visible = false
	# get_tree().paused = false


func _replace_last_node(new_scene_res: String) -> void:
	var scene_exists: bool = ResourceLoader.exists(new_scene_res)
	assert(scene_exists, "Scene Not Found")
	var last_node_index: int = get_child_count() - 1
	var last_node: Node = get_child(last_node_index)
	last_node.free()
	var new_scene: Resource = ResourceLoader.load(new_scene_res)
	var new_scene_ins: Node = new_scene.instantiate()
	add_child(new_scene_ins)


func return_to_home() -> void:
	var home_res: String = "res://scenes/landing/initial.tscn"
	call_deferred("_replace_last_node", home_res)


func player_fell() -> void:
	call_deferred("_replace_last_node", "res://scenes/layers/game_over.tscn")


func restart_level() -> void:
	on_level_selected(current_level_number)


func player_passed_level() -> void:
	call_deferred("_replace_last_node", "res://scenes/layers/level_passed.tscn")


func go_to_next_level() -> void:
	current_level_number += 1
	on_level_selected(current_level_number)


func on_level_selected(level: int) -> void:
	current_level_number = level
	var level_res: String = str("res://scenes/levels/level_", level, ".tscn")
	call_deferred("_replace_last_node", level_res)
