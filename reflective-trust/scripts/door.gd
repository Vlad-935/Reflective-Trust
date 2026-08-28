extends StaticBody2D

const SCALE_DURATION = 1.5

@export var INITIAL_POSITION = Vector2(64,-64)

var is_mirrored: bool = false
var move_multiplier: Vector2 = Vector2.ZERO

func _ready() -> void:
	global_position = INITIAL_POSITION

func _on_area_2d_body_entered(body: Node2D) -> void:
	var reflection = body.get_parent().get_node("Player_Reflection")
	body = reflection.get_parent().get_node("Player")
	
	# Win Particles
	body.find_child("*Win").emitting = true
	reflection.find_child("*Win").emitting = true
	
	reflection.can_move = false
	body.can_move = false
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(body, "scale", Vector2(0,0), SCALE_DURATION)
	tween.tween_property(reflection, "scale", Vector2(0,0), SCALE_DURATION)
	
	await get_tree().create_timer(1).timeout
	LevelManager.change_level()
