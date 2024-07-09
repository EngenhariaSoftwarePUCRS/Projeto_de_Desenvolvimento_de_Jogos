extends Node


@onready var settings_layer: CanvasLayer = $SettingsLayer

var configFile: ConfigFile = ConfigFile.new()
var currentLevelNumber: int

const CONFIG_FILE_PATH: String = "user://config.cfg"

enum LevelStatus { AVAILABLE, PASSED, LOCKED }


func _ready() -> void:
	settings_layer.visible = false
	load_settings()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_settings"):
		show_settings()


func mouse_show() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func mouse_hide() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func show_settings() -> void:
	# get_tree().paused = true
	settings_layer.visible = true
	mouse_show()


func close_settings() -> void:
	settings_layer.visible = false
	# get_tree().paused = false
	mouse_hide()


func _get_last_node() -> Node:
	var last_node_index: int = get_child_count() - 1
	var last_node: Node = get_child(last_node_index)
	return last_node


func _replace_last_node(new_scene_res: String) -> void:
	var scene_exists: bool = ResourceLoader.exists(new_scene_res)
	assert(scene_exists, "Scene Not Found")
	_get_last_node().free()
	var new_scene: Resource = ResourceLoader.load(new_scene_res)
	var new_scene_ins: Node = new_scene.instantiate()
	add_child(new_scene_ins)


func load_settings() -> void:
	var err: Error = configFile.load(CONFIG_FILE_PATH)
	if err != OK:
		configFile = ConfigFile.new()
		configFile.save(CONFIG_FILE_PATH)


func return_to_home() -> void:
	mouse_show()
	var home_res: String = "res://scenes/layers/initial.tscn"
	call_deferred("_replace_last_node", home_res)


func player_fell() -> void:
	mouse_show()
	call_deferred("_replace_last_node", "res://scenes/layers/game_over.tscn")


func restart_level() -> void:
	on_level_selected(currentLevelNumber)


func player_passed_level() -> void:
	mouse_show()
	assert(configFile.has_section("Levels"),
		"Could not find 'Levels' Section on Config File")
	configFile.set_value("Levels", str(currentLevelNumber), LevelStatus.PASSED)
	configFile.set_value("Levels", str(currentLevelNumber + 1), LevelStatus.AVAILABLE)
	configFile.save(CONFIG_FILE_PATH)
	call_deferred("_replace_last_node", "res://scenes/layers/level_passed.tscn")


func go_to_next_level() -> void:
	currentLevelNumber += 1
	on_level_selected(currentLevelNumber)


func on_level_selected(level: int) -> void:
	mouse_hide()
	currentLevelNumber = level
	var level_res: String = str("res://scenes/levels/level_", level, ".tscn")
	call_deferred("_replace_last_node", level_res)


func spawn_object_on_level(obj_instance: Node) -> void:
	var last_node: Node = _get_last_node()
	var is_last_node_name_valid_level: bool = str(last_node.name).begins_with("Level")
	assert(is_last_node_name_valid_level, "Last node is not a level")
	last_node.add_child.call_deferred(obj_instance)
