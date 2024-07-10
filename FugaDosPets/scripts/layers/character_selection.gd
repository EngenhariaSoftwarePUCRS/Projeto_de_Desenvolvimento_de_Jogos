extends CanvasLayer


@onready var change_ui: MarginContainer = $ChangeUI
@onready var franjinha_button: Control = $ChangeUI/Franjinha
@onready var monica_button: Control = $ChangeUI/Monica
@onready var cebolinha_button: Control = $ChangeUI/Cebolinha
@onready var cascao_button: Control = $ChangeUI/Cascao
@onready var magali_button: Control = $ChangeUI/Magali
@onready var change_cooldown: Timer = $ChangeCooldown
@onready var cooldown_label: Label = $ChangeCooldown/Label

var buttons: Array[Control]


func _ready() -> void:
	change_ui.visible = false
	buttons = [
		franjinha_button,
		monica_button,
		cebolinha_button,
		cascao_button,
		magali_button,
	]
	for button in buttons:
		button.pressed.connect(func() -> void:
			get_tree().call_group("characters", "change_character", button.name)
			change_ui.visible = false
			change_cooldown.start()
		)


func _process(_delta: float) -> void:
	if Input.is_action_pressed("change_characters"):
		if change_cooldown.time_left == 0.0:
			get_tree().call_group("main", "mouse_show")
			change_ui.visible = true
	else:
		change_ui.visible = false
	
	if change_cooldown.time_left > 0:
		var time_left: String = str(change_cooldown.time_left).pad_decimals(2)
		cooldown_label.text = str(time_left, " s ")
	else:
		cooldown_label.text = ""
	
	for button in buttons:
		if button.is_hovered():
			button.z_index = 99
		else:
			button.z_index = 0


func enable_change_character(character_name: String) -> void:
	var characterButton: String = str("ChangeUI/", character_name)
	assert(has_node(characterButton), "Invalid character button name to disable")
	get_node(characterButton).disabled = false


func disable_change_character(character_name: String) -> void:
	var characterButton: String = str("ChangeUI/", character_name)
	assert(has_node(characterButton), "Invalid character button name to disable")
	get_node(characterButton).disabled = true
