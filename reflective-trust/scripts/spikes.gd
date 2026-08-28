extends StaticBody2D

@export var INITIAL_POSITION = Vector2(64,-64)

var is_mirrored: bool = false
var move_multiplier: Vector2 = Vector2.ZERO

@onready var Root: Node2D = get_tree().get_root().get_node("Root")
@onready var Camera: Camera2D = Root.get_node("Camera2D")

func _ready() -> void:
	global_position = INITIAL_POSITION

func _on_area_2d_body_entered(body: Node2D) -> void:
	Camera.add_shake(5)
	
	# Delete Characters
	var reflection = body.get_parent().get_node("Player_Reflection")
	body = reflection.get_parent().get_node("Player")
	
	body.is_dead = true
	reflection.is_dead = true
	
	# Blood
	body.find_child("*Blood").emitting = true
	reflection.find_child("*Blood").emitting = true
	
	reflection.can_move = false
	body.can_move = false
	
	reflection.find_child("*Sprite").hide()
	body.find_child("*Sprite").hide()
	
	# Reset Level
	await get_tree().create_timer(1).timeout
	LevelManager.restart_level()
