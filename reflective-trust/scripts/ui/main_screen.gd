extends Control

@onready var Root: Node2D = get_parent().get_parent()

@onready var first_level_scene: PackedScene = preload("res://scenes/levels/level_1.tscn") 

@onready var Main_Screen: AspectRatioContainer = $MainScreen
@onready var Story: CenterContainer = $Story
@onready var Player_Select: CenterContainer = $Player_Select
@onready var Options: PanelContainer = $Options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	DisplayManager.can_be_paused = false
	Main_Screen.show()
	Player_Select.hide()
	Options.hide()


func _on_play_pressed() -> void:
	Story.start_story()
	Main_Screen.hide()

func _on_options_pressed() -> void:
	Main_Screen.hide()
	Options.show()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_mari_pressed() -> void:
	PlayerData.Character = "Isa"
	_start_game()


func _on_vlad_pressed() -> void:
	PlayerData.Character = "Vlad"
	_start_game()


func _start_game():
	# Fade in
	await Loading.fade_in()
	
	# Load first level
	var scene = first_level_scene.instantiate()
	Root.add_child(scene)
	scene.name = "Level_root"

	# Delete main screen
	self.queue_free()
	DisplayManager.can_be_paused = true
	
	# Hide Mouse
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# Change Music
	AudioManager.audio_scene.stream = AudioManager.game_song
	AudioManager.audio_scene.play()
	
	LevelManager.current_level = 1
	Loading.fade_out()


func _on_back_pressed() -> void:
	Options.hide()
	Main_Screen.show()
