extends StaticBody2D

@export var INITIAL_POSITION = Vector2.ZERO

var is_mirrored: bool = false
var has_shadow: bool = false
var move_multiplier: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = INITIAL_POSITION
