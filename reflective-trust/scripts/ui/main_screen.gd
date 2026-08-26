extends Control

@onready var Root: Node2D = get_parent().get_parent()
@onready var first_level_scene: PackedScene = preload("res://scenes/levels/level_1.tscn") 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Settings.can_be_paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	# Load first level
	var scene = first_level_scene.instantiate()
	Root.add_child(scene)

	print(scene)

	# Delete main screen
	self.queue_free()
	Settings.can_be_paused = true

func _on_options_pressed() -> void:
	pass


func _on_quit_pressed() -> void:
	get_tree().quit()
