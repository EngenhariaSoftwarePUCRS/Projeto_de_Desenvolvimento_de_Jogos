extends Control


@onready var play_again = $PlayAgain


func _on_settings_btn_pressed():
	get_tree().call_group("main", "show_settings")


func _on_play_again_pressed():
	get_tree().call_group("main", "restart_level")


func _on_exit_pressed():
	get_tree().call_group("main", "return_to_home")

