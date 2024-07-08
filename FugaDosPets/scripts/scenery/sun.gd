extends DirectionalLight2D


@export var MAX_ENERGY: float = 1.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var rising: bool = true


func _ready() -> void:
	energy = 0.75
	animated_sprite_2d.rotation = -rotation


func _process(delta: float) -> void:
	if energy < 0:
		return
	if rising:
		energy += 0.01 * delta
		if energy >= MAX_ENERGY:
			rising = false
	else:
		energy -= 0.05 * delta
	if energy <= 0:
		animated_sprite_2d.stop()
