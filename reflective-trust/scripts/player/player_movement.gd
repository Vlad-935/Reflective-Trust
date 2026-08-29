extends CharacterBody2D

@export var INITIAL_POSITION = Vector2(32,0)

const STEP = 32
const MOVE_DURATION = 1

var is_dead: bool = false
var can_move: bool = true

var direction: Vector2 = Vector2.ZERO
@export var move_multiplier: Vector2 = Vector2(1,1)

@onready var Sprite: AnimatedSprite2D = get_node(PlayerData.Character + " - Sprite")

var tiles: int = 0

func _ready() -> void:
	_player_setup()

func _physics_process(_delta: float) -> void:
	_get_direction()
	
	_get_collisions()
	_move()


func _player_setup():
	# Selecting Character
	var player_sprite
	var reflection_sprite
	
	if PlayerData.Character == "Isa":
		player_sprite = $"Isa - Sprite"
		reflection_sprite = $"Vlad - Sprite"
	else:
		player_sprite = $"Vlad - Sprite"
		reflection_sprite = $"Isa - Sprite"
		
	if move_multiplier == Vector2(1,1):
		reflection_sprite.queue_free()
	else:
		player_sprite.queue_free()
		Sprite = reflection_sprite
	
	# Mirroring the distance
	var player = get_parent().get_node("Player")
	global_position = player.INITIAL_POSITION * move_multiplier
	
	# Setting up the direction direction of the raycasts
	var Raycasts: Node2D = get_node("Raycasts")
	for raycast in Raycasts.get_children():
		raycast.target_position *= move_multiplier


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

func _move():
	if not can_move:
		direction = Vector2.ZERO
		return
	
	if direction == Vector2.ZERO:
		return
	
	var distance = direction * STEP * move_multiplier
	
	var collisions = _get_collisions()
	if collisions[direction] != null:
		var object = collisions[direction]

		if object.is_in_group("moveable") and object.try_move(distance):
			object.move_object(distance)
			
		else:
			return
		
		if object.is_in_group("wall"):
			return
	
	_move_player(distance)


func _move_player(distance):
	global_position += distance
	Sprite.global_position -= distance

	var tween = create_tween()
	tween.tween_property(Sprite, "global_position", self.global_position + Vector2(0,2), MOVE_DURATION).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)


func _get_collisions():
	var collisions: Dictionary[Vector2, Node2D] = {Vector2(1,0): null, Vector2(-1,0): null, Vector2(0,-1): null, Vector2(0,1): null}
	
	var Raycasts: Node2D = get_node("Raycasts")
	for raycast in Raycasts.get_children():
		var collision: Node2D = null
		if raycast.is_colliding():
			collision = raycast.get_collider()
		
		var raycast_direction = raycast.target_position.normalized() * move_multiplier
		collisions[raycast_direction] = collision
	
	return collisions


func on_shadow_entered():
	tiles += 1
	call_deferred("update_effect")

func on_shadow_exited():
	tiles -= 1
	call_deferred("update_effect")

func update_effect():
	if tiles > 0:
		Sprite.material.set_shader_parameter("active", true)
	else:
		Sprite.material.set_shader_parameter("active", false)
