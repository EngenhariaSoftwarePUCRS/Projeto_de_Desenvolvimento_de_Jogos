extends Control



func _on_settings_btn_pressed():
	get_tree().call_group("main", "show_settings")


func _on_next_level_pressed():
	get_tree().call_group("main", "go_to_next_level")


func _on_exit_pressed():
	get_tree().call_group("main", "return_to_home")
