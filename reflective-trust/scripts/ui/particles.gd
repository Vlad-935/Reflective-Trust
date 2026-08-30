extends CPUParticles2D

@onready var window_size = get_viewport().get_visible_rect().size

var Colors = [Color(1.0, 0.0, 0.0, 1.0),Color(1.0, 0.994, 0.0, 1.0),Color(0.0, 1.0, 0.137, 1.0),Color(0.0, 0.95, 0.897, 1.0),Color(0.556, 0.0, 1.0, 1.0)]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rand_x = randi_range(0, window_size.x)
	var rand_y = randi_range(0, window_size.y)
	
	global_position = Vector2(rand_x, rand_y)
	color = Colors[randi_range(0, 4)]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
