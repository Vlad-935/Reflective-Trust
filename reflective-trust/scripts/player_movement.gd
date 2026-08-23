extends CharacterBody2D

const INITIAL_POSITION = Vector2(64,64)

const STEP = 64
const MOVE_DURATION = 0.3

var direction: Vector2 = Vector2.ZERO
var is_moving: bool = false

@onready var Sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

func _ready() -> void:
	global_position = INITIAL_POSITION

func _physics_process(_delta: float) -> void:
	_get_direction()
	
	_handle_movement_buffer()
	_move_player()


func _handle_movement_buffer():
	if is_moving:
		await get_tree().create_timer(0.1).timeout
		is_moving = false

func _get_direction():
	if Input.is_action_just_pressed("move left"):
		direction = Vector2(-1,0)
	elif Input.is_action_just_pressed("move right"):
		direction = Vector2(1,0)
	elif Input.is_action_just_pressed("move up"):
		direction = Vector2(0,-1)
	elif Input.is_action_just_pressed("move down"):
		direction = Vector2(0,1)
	else:
		direction = Vector2.ZERO

func _move_player():
	if direction == Vector2.ZERO:
		return
	
	if is_moving:
		return
	
	var distance = direction * STEP
	
	global_position += distance
	Sprite.global_position -= distance

	var tween = create_tween()
	tween.tween_property(Sprite, "global_position", global_position, MOVE_DURATION).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

	is_moving = true
