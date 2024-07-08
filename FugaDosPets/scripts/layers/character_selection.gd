extends CanvasLayer


@onready var franjinha_button: Control = $MarginContainer/Franjinha
@onready var monica_button: Control = $MarginContainer/Monica
@onready var cebolinha_button: Control = $MarginContainer/Cebolinha
@onready var cascao_button: Control = $MarginContainer/Cascao
@onready var magali_button: Control = $MarginContainer/Magali

var buttons: Array[Control]


func _ready() -> void:
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
		)

func _process(_delta: float) -> void:
	for button in buttons:
		if button.is_hovered():
			button.z_index = 99
		else:
			button.z_index = 0
