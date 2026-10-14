extends Node

var can_be_paused: bool = true

var is_fullscreen: bool = false
var resolution_index: int = 1

var available_resolutions: Array[Vector2i] = [
	Vector2i(1920, 1080),
	Vector2i(1280, 720),
	Vector2i(720, 480),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_fullscreen(is_fullscreen)
	set_resolution(resolution_index)


func set_fullscreen(enabled):
	is_fullscreen = enabled
	if enabled:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
		set_resolution(resolution_index)


func set_resolution(index):
	resolution_index = index
	if not is_fullscreen:
		var resolution = available_resolutions[index]
		DisplayServer.window_set_size(resolution)
		_center_window()


func _center_window():
	var screen_size = DisplayServer.screen_get_size()
	var window_size = DisplayServer.window_get_size()
	
	DisplayServer.window_set_position((screen_size - window_size) / 2.0)
