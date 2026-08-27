extends Node
class_name StateMachine

var current_state: String = "idle"
var direction: String = "front"

@onready var Player: CharacterBody2D = get_parent()
@onready var Sprite: AnimatedSprite2D = Player.Sprite

func _physics_process(_delta: float) -> void:
	if Sprite == null:
		Sprite = Player.Sprite
	
	_flip_sprite()
	
	var state_changed = _get_state()
	var direction_changed = _get_direction()
	
	if state_changed == true or direction_changed == true:
		print(current_state, direction)
		_set_animation()

func _get_state():
	var new_state
	if abs(Sprite.position.x) <= 3 and abs(Sprite.position.y) <= 5:
		new_state = "idle"
	else:
		new_state = "walk"

	if new_state == current_state:
		return false
	
	current_state = new_state
	return true

func _get_direction():
	if Sprite.position == Vector2(0,2):
		return
	
	var new_direction: String
	
	if Player.direction == Vector2.UP:
		new_direction = "back"
	elif Player.direction == Vector2.DOWN:
		new_direction = "front"
	elif Player.direction == Vector2.RIGHT or Player.direction == Vector2.LEFT:
		new_direction = "side"
		
	if new_direction == direction or new_direction == "":
		return false
	
	direction = new_direction
	return true


func _flip_sprite():
	if Player.direction * Player.move_multiplier == Vector2.RIGHT:
		Sprite.flip_h = false
	elif Player.direction * Player.move_multiplier == Vector2.LEFT:
		Sprite.flip_h = true


func _set_animation():
	Sprite.play(current_state + "_" + direction)
