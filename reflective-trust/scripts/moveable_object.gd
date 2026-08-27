extends StaticBody2D

@export var INITIAL_POSITION = Vector2(64, 0)

const STEP = 64
const MOVE_DURATION = 0.3

var is_moving: bool = false

var is_mirrored: bool = false
var move_multiplier: Vector2 = Vector2(1,1)

# Nodes
@onready var Level: = get_parent().get_parent()

@onready var Player: CharacterBody2D = Level.get_node("Player")
@onready var Sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = INITIAL_POSITION
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func try_move(distance):
	var space_state = get_world_2d().direct_space_state
	var collider: Area2D = $Area2D
	var shape = $Area2D/CollisionShape2D.shape
	
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.transform = Transform2D(0, global_position + distance)
	query.collision_mask = collider.collision_mask
	
	var result = space_state.intersect_shape(query)
	return result.is_empty()

func move_object(distance):
	global_position += distance
	Sprite.global_position -= distance
	
	if is_mirrored:
		var Shadow = get_node("Shadow")
		Shadow.global_position -= distance
		
		var shadow_tween = create_tween()
		shadow_tween.tween_property(Shadow, "global_position", self.global_position, MOVE_DURATION).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		
		

	var tween = create_tween()
	tween.tween_property(Sprite, "global_position", self.global_position, MOVE_DURATION).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
