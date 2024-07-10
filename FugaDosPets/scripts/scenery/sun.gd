extends DirectionalLight2D


@export var MAX_ENERGY: float = 1.0

@onready var happy_sprite: AnimatedSprite2D = $HappySprite

var rising: bool = true


func _ready() -> void:
	energy = 0.75
	happy_sprite.rotation = -rotation


func _process(delta: float) -> void:
	if energy < 0:
		return
	if rising:
		energy += 0.005 * delta
		if energy >= MAX_ENERGY:
			rising = false
	else:
		energy -= 0.05 * delta
	if energy <= 0:
		happy_sprite.stop()
