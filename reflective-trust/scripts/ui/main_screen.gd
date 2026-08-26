extends Control

@onready var Root: Node2D = get_parent().get_parent()

@onready var first_level_scene: PackedScene = preload("res://scenes/levels/level_1.tscn") 

@onready var Loading_Screen: Control = $"../Loading"
@onready var Player_Select: CenterContainer = $Player_Select

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Settings.can_be_paused = false
	Player_Select.hide()


func _on_play_pressed() -> void:
	Player_Select.show()


func _on_options_pressed() -> void:
	pass


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
	await Loading_Screen.fade_in()
	
	# Load first level
	var scene = first_level_scene.instantiate()
	Root.add_child(scene)

	# Delete main screen
	self.queue_free()
	Settings.can_be_paused = true
	
	Loading_Screen.fade_out()
