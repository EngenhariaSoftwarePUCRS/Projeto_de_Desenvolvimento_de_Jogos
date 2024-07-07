extends Node


@onready var settings_layer: CanvasLayer = $SettingsLayer
@onready var current_level: Node
@onready var player: Node2D
@onready var sceneLimit: Marker2D
@onready var spawnPoint: Marker2D

var current_level_number: int


func _ready() -> void:
	settings_layer.visible = false


func _input(event: InputEvent) -> void:
	current_level = get_level()
	
	if event.is_action_pressed("open_settings"):
		print("Openning Settings")
		show_settings()
		if current_level != null:
			get_tree().call_group("level1", "set_active_camera", "MenuCamera")


func _physics_process(_delta: float) -> void:
	if get_level() == null or player == null:
		return
	if player.position.y > sceneLimit.position.y:
		call_deferred("_replace_last_node", "res://scenes/layers/game_over.tscn")
	if player.position.x > sceneLimit.position.x:
		call_deferred("_replace_last_node", "res://scenes/layers/level_passed.tscn")


func get_level() -> Node:
	var last_node_index: int = get_child_count() - 1
	var last_node: Node = get_child(last_node_index)
	var last_node_name: String = str(last_node.get_path())
	if last_node_name.contains("/Level"):
		set_level_params(last_node.name)
		return last_node
	return null


func set_level_params(level_name: String) -> void:
	if player == null:
		var player_node: String = str(level_name, "/Player")
		player = get_node(player_node)
	
	if sceneLimit == null:
		var scene_limit_node: String = str(level_name, "/SceneLimit")
		sceneLimit = get_node(scene_limit_node)
	
	if spawnPoint == null:
		var spawn_point_node: String = str(level_name, "/SpawnPoint")
		spawnPoint = get_node(spawn_point_node)


func show_settings() -> void:
	# get_tree().paused = true
	settings_layer.visible = true


func close_settings() -> void:
	settings_layer.visible = false
	if get_level() != null:
		get_tree().call_group("level1", "reset_camera")
	# get_tree().paused = false


func _replace_last_node(new_scene_res: String) -> void:
	var scene_exists: bool = ResourceLoader.exists(new_scene_res)
	if not scene_exists:
		print("Scene Not Found")
		return
	var last_node_index: int = get_child_count() - 1
	var last_node: Node = get_child(last_node_index)
	last_node.free()
	var new_scene: Resource = ResourceLoader.load(new_scene_res)
	var new_scene_ins: Node = new_scene.instantiate()
	add_child(new_scene_ins)


func return_to_home() -> void:
	var home_res: String = "res://scenes/landing/initial.tscn"
	call_deferred("_replace_last_node", home_res)


func restart_level() -> void:
	on_level_selected(current_level_number)


func go_to_next_level() -> void:
	current_level_number += 1
	on_level_selected(current_level_number)


func on_level_selected(level: int) -> void:
	current_level_number = level
	var level_res: String = str("res://scenes/levels/level_", level, ".tscn")
	call_deferred("_replace_last_node", level_res)
