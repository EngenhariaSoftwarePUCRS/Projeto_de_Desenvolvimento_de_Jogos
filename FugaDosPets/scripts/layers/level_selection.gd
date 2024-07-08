extends CanvasLayer


@onready var template_button: Button = $TemplateButton
@onready var levels_grid: GridContainer = $LevelsGrid

var configFile: ConfigFile = ConfigFile.new()

enum LevelStatus { AVAILABLE, PASSED, LOCKED }


func _ready() -> void:
	var err: Error = configFile.load("user://config.cfg")
	if err != OK:
		print("Could not load available levels file")
		return
	
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
