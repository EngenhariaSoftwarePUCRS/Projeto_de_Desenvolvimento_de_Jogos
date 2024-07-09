extends CanvasLayer


@onready var template_button: Button = $TemplateButton
@onready var levels_grid: GridContainer = $LevelsGrid

var configFile: ConfigFile = ConfigFile.new()

const CONFIG_FILE_PATH: String = "user://config.cfg"
const LAST_LEVEL: int = 4 # 8

enum LevelStatus { AVAILABLE, PASSED, LOCKED }


func _ready() -> void:
	var err: Error = configFile.load(CONFIG_FILE_PATH)
	if err != OK:
		get_tree().call_group("main", "load_settings")
	
	if not configFile.has_section("Levels"):
		configFile.set_value("Levels", str(1), LevelStatus.AVAILABLE)
		for i in range(2, LAST_LEVEL + 1):
			configFile.set_value("Levels", str(i), LevelStatus.LOCKED)
		configFile.save(CONFIG_FILE_PATH)
	
	for level in configFile.get_section_keys("Levels"):
		var status: int = configFile.get_value("Levels", level)
		
		var level_btn: Button = template_button.duplicate()
		level_btn.visible = true
		level_btn.disabled = status == LevelStatus.LOCKED
		level_btn.text = level
		level_btn.pressed.connect(func() -> void:
			get_tree().call_group("main", "on_level_selected", int(level))
		)
		levels_grid.add_child(level_btn)
