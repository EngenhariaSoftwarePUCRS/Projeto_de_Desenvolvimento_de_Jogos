extends CanvasLayer

@onready var music_slider: HSlider = $MarginContainer/Interactive/Music/MusicSlider
@onready var sfx_slider: HSlider = $MarginContainer/Interactive/SFX/SFXSlider

var configFile: ConfigFile = ConfigFile.new()
var MUSIC_BUS: int = AudioServer.get_bus_index("Music")
var SFX_BUS: int = AudioServer.get_bus_index("SFX")

const CONFIG_FILE_PATH: String = "user://config.cfg"


func _ready() -> void:
	var err: Error = configFile.load(CONFIG_FILE_PATH)
	if err != OK:
		get_tree().call_group("main", "load_settings")
	
	if not configFile.has_section("Audio"):
		configFile.set_value("Audio", "Music", db_to_linear(AudioServer.get_bus_volume_db(MUSIC_BUS)))
		configFile.set_value("Audio", "SFX", db_to_linear(AudioServer.get_bus_volume_db(SFX_BUS)))
		configFile.save(CONFIG_FILE_PATH)
	
	update_music(configFile.get_value("Audio", "Music"))
	update_sfx(configFile.get_value("Audio", "SFX"))


func _on_close_pressed() -> void:
	configFile.save(CONFIG_FILE_PATH)
	get_tree().call_group("main", "close_settings")


func update_music(volume: float) -> void:
	music_slider.value = volume
	AudioServer.set_bus_volume_db(MUSIC_BUS, linear_to_db(volume))
	configFile.set_value("Audio", "Music", volume)


func _on_music_off_pressed() -> void:
	update_music(0.0)


func _on_music_slider_value_changed(value: float) -> void:
	update_music(value)


func _on_music_on_pressed() -> void:
	update_music(1.0)


func update_sfx(volume: float) -> void:
	sfx_slider.value = volume
	AudioServer.set_bus_volume_db(SFX_BUS, linear_to_db(volume))
	configFile.set_value("Audio", "SFX", volume)


func _on_sfx_off_pressed() -> void:
	update_sfx(0.0)


func _on_sfx_slider_value_changed(value: float) -> void:
	update_sfx(value)


func _on_sfx_on_pressed() -> void:
	update_sfx(1.0)


func _on_exit_pressed() -> void:
	configFile.save(CONFIG_FILE_PATH)
	get_tree().call_group("main", "return_to_home")
	visible = false
