extends CharacterBody2D

const INITIAL_POSITION = Vector2(0,64)

const STEP = 64
const MOVE_DURATION = 0.3

var direction: Vector2 = Vector2.ZERO
@export var move_multiplier: Vector2 = Vector2(1,1)

@onready var Sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

func _ready() -> void:
	_player_setup()

func _physics_process(_delta: float) -> void:
	_get_direction()
	
	_move_player()

func _player_setup():
	# Mirroring the distance
	global_position = INITIAL_POSITION * move_multiplier
	
	# Setting up the direction direction of the raycasts
	var Raycasts: Node2D = get_node("Raycasts")
	for raycast in Raycasts.get_children():
		raycast.target_position *= move_multiplier


func _get_direction():
	if Input.is_action_just_pressed("move left") and not $Raycasts/Right.is_colliding():
		direction = Vector2(-1,0)
	elif Input.is_action_just_pressed("move right") and not $Raycasts/Left.is_colliding():
		direction = Vector2(1,0)
	elif Input.is_action_just_pressed("move up") and not $Raycasts/Up.is_colliding():
		direction = Vector2(0,-1)
	elif Input.is_action_just_pressed("move down") and not $Raycasts/Down.is_colliding():
		direction = Vector2(0,1)
	else:
		direction = Vector2.ZERO

func _move_player():
	if direction == Vector2.ZERO:
		return
	
	var distance = direction * STEP * move_multiplier
	
	global_position += distance
	Sprite.global_position -= distance

	var tween = create_tween()
	tween.tween_property(Sprite, "global_position", self.global_position, MOVE_DURATION).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
