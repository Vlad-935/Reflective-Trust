extends StaticBody2D

const STEP = 64
const INITIAL_POSITION = Vector2.ZERO

var is_moving: bool = false

@onready var Player: CharacterBody2D = get_parent().get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = INITIAL_POSITION
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Player.direction == Vector2.ZERO:
		is_moving = false
	
	if is_moving:
		return

	if $Raycasts/Right.is_colliding() and Player.direction == Vector2(-1,0):
		position += Player.direction * STEP
		is_moving = true
	elif $Raycasts/Left.is_colliding() and Player.direction == Vector2(1,0):
		position += Player.direction * STEP
		is_moving = true
	elif $Raycasts/Up.is_colliding() and Player.direction == Vector2(0,1):
		position += Player.direction * STEP
		is_moving = true
	elif $Raycasts/Down.is_colliding() and Player.direction == Vector2(0,-1):
		position += Player.direction * STEP
		is_moving = true
	
	pass
