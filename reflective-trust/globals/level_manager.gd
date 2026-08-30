extends Node

var current_level: int = 1
var is_changing_level: bool = false
var is_restarting: bool = false

var level_path: String = "res://scenes/levels/level_"
var end_game_path: PackedScene = preload("res://scenes/ui/end_screen.tscn")

@onready var Root: Node2D = get_parent().get_node("Root")

func restart_level():
	if is_restarting:
		return
	
	is_restarting = true
	change_scene()
	
	await get_tree().create_timer(2).timeout
	is_restarting = false


func change_level():
	if is_changing_level or is_restarting:
		return
	
	if current_level == 11:
		load_end_game_scene()
		return
	
	is_changing_level = true
	await get_tree().create_timer(0.5).timeout
	current_level += 1
	change_scene()
	
	await get_tree().create_timer(2).timeout
	is_changing_level = false


func change_scene():
	var level = Root.get_node("Level_root")
	var new_level_scene = load(level_path + str(current_level) + ".tscn")
	var new_level = new_level_scene.instantiate()
	
	await Loading.fade_in()

	level.queue_free()
	
	await get_tree().create_timer(0.1).timeout
	
	Root.add_child(new_level)
	new_level.name = "Level_root"

	Loading.fade_out()


func load_end_game_scene():
	# Change Scene
	await Loading.fade_in()
	get_tree().change_scene_to_packed(end_game_path)
	
	
	# Change Audio
	await Loading.fade_out()
	AudioManager.audio_scene.stream = AudioManager.end_game_song
	AudioManager.audio_scene.play()

	# Free Mouse
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset level"):
		restart_level()
