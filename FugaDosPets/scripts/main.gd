extends Node


@onready var settings_layer: CanvasLayer = $SettingsLayer
@onready var level : Node
@onready var player : Node2D
@onready var sceneLimit : Marker2D
@onready var spawnPoint : Marker2D

var current_level: int


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_settings"):
		print("Openning Settings")
		show_settings()
	
	if get_level() == null:
		return
	const characters = ["franjinha", "monica", "cebolinha", "cascao", "magali"]
	for character in characters:
		if event.is_action_pressed("change_character_to_" + character):
			print(str("Changing to ", character))
			get_tree().call_group("character", "change_character",
				character, player.position.x, player.position.y)


func _physics_process(_delta) -> void:
	level = get_level()
	if level == null:
		return
	if player.position.y > sceneLimit.position.y:
		call_deferred("_replace_last_node", "res://scenes/game_over.tscn")


func get_level() -> Node:
	var last_node_index: int = get_child_count() - 1
	var last_node = get_child(last_node_index)
	var last_node_name = str(last_node.get_path())
	if last_node_name.contains("/Level"):
		set_level_params(last_node.name)
		return last_node
	return null


func set_level_params(level_name: String) -> void:
	if player == null:
		var player_node = str(level_name, "/Player")
		player = get_node(player_node)
	
	if sceneLimit == null:
		var scene_limit_node = str(level_name, "/SceneLimit")
		sceneLimit = get_node(scene_limit_node)
	
	if spawnPoint == null:
		var spawn_point_node = str(level_name, "/SpawnPoint")
		spawnPoint = get_node(spawn_point_node)


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
	var new_scene := ResourceLoader.load(new_scene_res)
	var new_scene_ins = new_scene.instantiate()
	add_child(new_scene_ins)


func return_to_home() -> void:
	var home_res := "res://scenes/landing/initial.tscn"
	call_deferred("_replace_last_node", home_res)


func restart_level() -> void:
	on_level_selected(current_level)


@warning_ignore("shadowed_variable")
func on_level_selected(level: int) -> void:
	current_level = level
	var level_res := str("res://scenes/levels/level_", level, ".tscn")
	call_deferred("_replace_last_node", level_res)
