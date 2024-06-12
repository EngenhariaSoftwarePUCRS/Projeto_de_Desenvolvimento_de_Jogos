extends Node


@onready var camera_a: Camera2D = $CameraA
@onready var camera_b: Camera2D = $CameraB
@onready var camera_c: Camera2D = $CameraC
@onready var camera_d: Camera2D = $CameraD
@onready var character: CharacterBody2D = $Character
@onready var checkpoint_a: Area2D = $Scenery/CheckpointA
@onready var checkpoint_b: Area2D = $Scenery/CheckpointB
@onready var checkpoint_c: Area2D = $Scenery/CheckpointC


func _ready() -> void:
	set_active_camera(camera_a)


func set_active_camera(camera: Camera2D) -> void:
	camera.make_current()


func _on_checkpoint_a_body_entered(body: Node2D) -> void:
	checkpoint_a.queue_free()
	set_active_camera(camera_b)
	get_tree().call_group("character", "change_character", "cebolinha")


func _on_checkpoint_b_body_entered(body: Node2D) -> void:
	checkpoint_b.queue_free()
	set_active_camera(camera_c)
	get_tree().call_group("character", "change_character", "cascao")


func _on_checkpoint_c_body_entered(body: Node2D) -> void:
	checkpoint_c.queue_free()
	set_active_camera(camera_d)
	get_tree().call_group("character", "change_character", "magali")
