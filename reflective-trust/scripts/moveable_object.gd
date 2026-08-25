extends StaticBody2D

const STEP = 64
var INITIAL_POSITION = Vector2(64, 64)

var is_moving: bool = false

var is_mirrored: bool = false
var move_multiplier: Vector2 = Vector2(1,1)

# Nodes
@onready var Root: Node2D = get_parent().get_parent()

@onready var Player: CharacterBody2D = Root.get_parent().get_node("Player")

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
		position += Player.direction * STEP * move_multiplier
		is_moving = true
	elif $Raycasts/Left.is_colliding() and Player.direction == Vector2(1,0):
		position += Player.direction * STEP * move_multiplier
		is_moving = true
	elif $Raycasts/Up.is_colliding() and Player.direction == Vector2(0,1):
		position += Player.direction * STEP * move_multiplier
		is_moving = true
	elif $Raycasts/Down.is_colliding() and Player.direction == Vector2(0,-1):
		position += Player.direction * STEP * move_multiplier
		is_moving = true
	
	pass
