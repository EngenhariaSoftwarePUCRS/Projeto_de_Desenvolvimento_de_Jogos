extends Node


@onready var player: Node2D = $Player
@onready var scene_limit: Marker2D = $SceneLimit
@onready var invisible_wall: StaticBody2D = $Scenery/InvisibleWall
@onready var invisible_floor: StaticBody2D = $Scenery/InvisibleFloor
@onready var a_map: TileMap = $Scenery/AMap
@onready var b_map: TileMap = $Scenery/BMap
@onready var c_map: TileMap = $Scenery/CMap
@onready var lever_lower: AnimatableBody2D = $Scenery/LeverLower
@onready var branch_2: StaticBody2D = $Scenery/Branch2
@onready var lever_upper: AnimatableBody2D = $Scenery/LeverUpper
@onready var branch: StaticBody2D = $Scenery/Branch
@onready var collectible: Area2D = $Scenery/Collectible
@onready var lever_right: AnimatableBody2D = $Scenery/LeverRight
@onready var lever_left: AnimatableBody2D = $Scenery/LeverLeft
@onready var gate: Area2D = $Scenery/Gate

var gate_locks: Array[bool]


func _ready() -> void:
	gate_locks = [true, true, true, true]
	
	player.sceneLimit = Vector2(scene_limit.position.x, scene_limit.position.y)
	player.change_character("Magali")
	
	get_tree().call_group("characters", "disable_change_character", "Monica")
	
	branch_2.visible = false
	
	b_map.set_layer_enabled(0, false)
	b_map.set_layer_enabled(1, false)
	lever_upper.visible = false
	
	c_map.set_layer_enabled(0, false)
	c_map.set_layer_enabled(1, false)
	branch.visible = false
	lever_right.visible = false
	
	lever_left.visible = false
	
	
	lever_lower.on_pull(func() -> void:
		gate_locks[0] = false
		branch_2.visible = true
		b_map.set_layer_enabled(0, true)
		b_map.set_layer_enabled(1, true)
		lever_upper.visible = true
		invisible_wall.queue_free()
	)
	
	lever_upper.on_pull(func() -> void:
		gate_locks[1] = false
		c_map.set_layer_enabled(0, true)
		c_map.set_layer_enabled(1, true)
		branch.visible = true
		lever_right.visible = true
		invisible_floor.queue_free()
		get_tree().call_group("characters", "enable_change_character", "Monica")
	)
	
	lever_right.on_pull(func() -> void:
		gate_locks[2] = false
		lever_left.visible = true
		for lock in gate_locks:
			if lock:
				return
		gate.visible = false
	)
	
	lever_left.on_pull(func() -> void:
		gate_locks[3] = false
		for lock in gate_locks:
			if lock:
				return
		gate.visible = false
	)


func _on_collectible_body_entered(_body: Node2D) -> void:
	collectible.get_node("Popup").visible = true


func is_character(character_name: String) -> bool:
	const CHARACTER_NAMES: Array[String] = [
		"Monica", "Cebolinha", "Cascao", "Magali"]
	return CHARACTER_NAMES.has(character_name)


func _on_gate_body_entered(body: Node2D) -> void:
	if not is_character(body.name):
		return
	for lock_i in gate_locks.size():
		if gate_locks[lock_i]:
			get_tree().call_group("main", "mouse_show")
			gate.get_node("LockedDialog").show()
			return
	gate.visible = false


func _on_dialog_closed() -> void:
	get_tree().call_group("main", "mouse_hide")


func _on_bidu_body_entered(body: Node2D) -> void:
	if not is_character(body.name):
		return
	for lock in gate_locks:
		if lock:
			return
	get_tree().call_group("main", "player_passed_level")
