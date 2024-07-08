extends CanvasLayer


@onready var levels_grid = $LevelsGrid

var configFile = ConfigFile.new()

enum LevelStatus { AVAILABLE, PASSED, LOCKED }


func _ready() -> void:
	var err: Error = configFile.load("user://config.cfg")
	assert(err == OK, "Could not load available levels file")
	
	var levels: Dictionary
	for level in configFile.get_section_keys("Levels"):
		var status = configFile.get_value("Levels", level)
		levels[level] = status
	
	for level_btn in levels_grid.get_children():
		var level: String = level_btn.text
		assert(levels.has(level),
			"Inconsistency between levels array and level selection buttons")
		
		level_btn.pressed.connect(func() -> void:
			get_tree().call_group("main", "on_level_selected", int(level))
		)
		
		var status = levels.get(level)
		if status == LevelStatus.LOCKED:
			level_btn.disabled = true
		elif status == LevelStatus.PASSED:
			pass
		elif status == LevelStatus.AVAILABLE:
			pass
