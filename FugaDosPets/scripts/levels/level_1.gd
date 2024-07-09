extends Node


@onready var camera_a: Camera2D = $CameraA
@onready var camera_b: Camera2D = $CameraB
@onready var camera_c: Camera2D = $CameraC
@onready var camera_d: Camera2D = $CameraD
@onready var player: Node2D = $Player
@onready var scene_limit: Marker2D = $SceneLimit
@onready var checkpoint_a: Area2D = $Scenery/CheckpointA
@onready var checkpoint_b: Area2D = $Scenery/CheckpointB
@onready var checkpoint_c: Area2D = $Scenery/CheckpointC
@onready var collectible_1: Area2D = $Scenery/Collectible1
@onready var tree: Sprite2D = $Scenery/Tree
@onready var lever_1: AnimatableBody2D = $Scenery/Lever1
@onready var lever_2: AnimatableBody2D = $Scenery/Lever2
@onready var gate: StaticBody2D = $Scenery/Gate


func _ready() -> void:
	player.sceneLimit = Vector2(scene_limit.position.x, scene_limit.position.y)
	player.change_character("Monica")
	
	camera_a.make_current()
	
	tree.visible = false
	for branch in tree.get_children():
		branch.get_node("Collider").disabled = true
	var show_branches: Callable = func() -> void:
		tree.visible = true
		for branch in tree.get_children():
			branch.get_node("Collider").disabled = false
	lever_1.on_pull(show_branches)
	
	var open_gate: Callable = func() -> void:
		gate.open()
	lever_2.on_pull(open_gate)


func _on_checkpoint_a_body_entered(_body: Node2D) -> void:
	checkpoint_a.queue_free()
	camera_b.make_current()
	player.change_character("Cebolinha")


func _on_checkpoint_b_body_entered(_body: Node2D) -> void:
	checkpoint_b.queue_free()
	camera_c.make_current()
	player.change_character("Cascao")


func _on_checkpoint_c_body_entered(_body: Node2D) -> void:
	checkpoint_c.queue_free()
	camera_d.make_current()
	player.change_character("Magali")


func _on_collectible_1_body_entered(_body: Node2D) -> void:
	collectible_1.queue_free()
	print("Você sabia que a turminha começou a aparecer em sua própria revista em 1970?")
