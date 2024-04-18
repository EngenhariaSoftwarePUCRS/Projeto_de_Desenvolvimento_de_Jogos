extends CanvasLayer

@onready var scoreLabel : Label = $Score

func _ready() -> void:
	setScore(0)

func updateScore()
	print("Updating HUD score")

func setScore(score: int):
	scoreLabel.text = "Score: " + str(score)
