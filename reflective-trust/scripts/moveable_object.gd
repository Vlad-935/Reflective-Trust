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

	var collision_direction = _get_collisions()

	if (
		collision_direction["Right"][0] == "player" and not collision_direction["Left"][0] == "wall"
		and Player.direction == Vector2(-1,0)
	):
		is_moving = true
		
	elif (
		collision_direction["Left"][0] == "player" and not collision_direction["Right"][0] == "wall"
		and Player.direction == Vector2(1,0)
	):	
		is_moving = true
	
	elif (
		collision_direction["Up"][0] == "player" and not collision_direction["Down"][0] == "wall"
		and Player.direction == Vector2(0,1)
	):	
		is_moving = true
		
	elif (collision_direction["Down"][0] == "player" and not collision_direction["Up"][0] == "wall"
		and Player.direction == Vector2(0,-1)
	):
		is_moving = true
		
	if is_moving:
		position += Player.direction * STEP * move_multiplier

func _get_collisions():
	var collision_direction: Dictionary[String, Array] = {"Right": [""], "Left": [""], "Up": [""], "Down": [""]}
	
	var Raycasts: Node2D = get_node("Raycasts")
	for raycast in Raycasts.get_children():
		var collision: Array = ["none"]
		if raycast.is_colliding():
			collision = raycast.get_collider().get_groups()
		
		collision_direction[raycast.name] = collision
	
	return collision_direction
