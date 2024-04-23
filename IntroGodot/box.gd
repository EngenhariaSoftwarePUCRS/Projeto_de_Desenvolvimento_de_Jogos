extends Area2D

func _ready() -> void:
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
	#tween.tween_property(self, "scale", Vector2(0.688, 0.703), 0.2)
	#tween.tween_property(self, "scale", Vector2(0.313, 0.313), 0.2)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("Saiu!")
	queue_free()
