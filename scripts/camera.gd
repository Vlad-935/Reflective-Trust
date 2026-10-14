extends Camera2D

const SHAKE_DECAY = 10

var shake_strength: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_camera_shake(delta)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset level") and not LevelManager.is_restarting:
		add_shake(5)


func _camera_shake(delta: float) -> void:
	var shake_velocity: Vector2 = Vector2.ZERO
	if shake_strength > 0.0:
		shake_strength = move_toward(shake_strength, 0.0, SHAKE_DECAY * delta)
		shake_velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0,1.0)) * shake_strength
	
	offset = shake_velocity


func add_shake(amount):
	shake_strength = amount
