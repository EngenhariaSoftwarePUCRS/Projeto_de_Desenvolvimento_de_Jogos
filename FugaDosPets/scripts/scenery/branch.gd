extends StaticBody2D


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _on_area_2d_body_entered(_body: Node2D) -> void:
	if not audio_stream_player_2d.playing:
		audio_stream_player_2d.play()


func _on_area_2d_body_exited(_body: Node2D) -> void:
		audio_stream_player_2d.stop()
