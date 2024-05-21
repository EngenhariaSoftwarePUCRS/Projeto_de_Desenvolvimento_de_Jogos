extends CanvasLayer

@onready var music_slider: HSlider = $MarginContainer/Interactive/Music/MusicSlider
@onready var sfx_slider: HSlider = $MarginContainer/Interactive/SFX/SFXSlider

var MUSIC_BUS: int = AudioServer.get_bus_index("Music")
var SFX_BUS: int = AudioServer.get_bus_index("SFX")


func _ready() -> void:
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(MUSIC_BUS))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(SFX_BUS))


func _on_close_pressed() -> void:
	visible = false


func update_music(volume: float) -> void:
	music_slider.value = volume
	AudioServer.set_bus_volume_db(MUSIC_BUS, linear_to_db(volume))


func _on_music_off_pressed() -> void:
	update_music(0.0)


func _on_music_slider_value_changed(value: float) -> void:
	update_music(value)


func _on_music_on_pressed() -> void:
	update_music(1.0)


func update_sfx(volume: float) -> void:
	sfx_slider.value = volume
	AudioServer.set_bus_volume_db(SFX_BUS, linear_to_db(volume))


func _on_sfx_off_pressed() -> void:
	update_sfx(0.0)


func _on_sfx_slider_value_changed(value: float) -> void:
	update_sfx(value)


func _on_sfx_on_pressed() -> void:
	update_sfx(1.0)
