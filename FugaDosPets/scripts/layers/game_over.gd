extends Control


@onready var play_again: Button = $PlayAgain


func _on_settings_btn_pressed() -> void:
	get_tree().call_group("main", "show_settings")


func _on_play_again_pressed() -> void:
	get_tree().call_group("main", "restart_level")


func _on_exit_pressed() -> void:
	get_tree().call_group("main", "return_to_home")

