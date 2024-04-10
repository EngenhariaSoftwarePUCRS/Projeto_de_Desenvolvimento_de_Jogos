extends Node2D


const SPEED : int = 100

var total: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score(total)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	total += delta
	update_score(total)
	
	## Used for continuous actions (movement)
	#if Input.is_action_pressed("ui_left"):
		#position.x -= SPEED * delta # Pixels/segundo
	#elif Input.is_action_pressed("ui_right"):
		#position.x += SPEED * delta

func _input(event: InputEvent) -> void:
	# Used for single presses, such as "ESC" for menu, for example
	if event.is_action_pressed("ui_end"):
		print("Ui End!\n")

func update_score(score: float) -> void:
	# get_node("Score")
	$Score.text = str(score)
