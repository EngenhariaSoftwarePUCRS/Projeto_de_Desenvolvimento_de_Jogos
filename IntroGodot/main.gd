extends Node2D


var total: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score(total)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	total += delta
	update_score(total)

func update_score(score: float) -> void:
	# get_node("Score")
	$Score.text = str(score)
