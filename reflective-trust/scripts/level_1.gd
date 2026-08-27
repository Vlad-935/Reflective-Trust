extends Node2D

const REFLECTION_MULTIPLIER = Vector2(-1,1)

@onready var Nodes: Node2D = $Objects
@onready var Shadow_Scene: PackedScene = preload("res://scenes/shadow.tscn")

func _ready() -> void:
	_duplicate_children()


func _duplicate_children():
	for child in Nodes.get_children():
		var path = child.get_scene_file_path() 
		var scene = load(path)
		
		var new_child = scene.instantiate()
		Nodes.add_child(new_child)
		
		_mirrored_setup(new_child, child)

func _mirrored_setup(reflection, child):
	reflection.is_mirrored = true
	
	# Position Reflection
	reflection.position = child.position * REFLECTION_MULTIPLIER
	reflection.move_multiplier = Vector2(1,-1)
	
	# Add Shadow
	var shadow = Shadow_Scene.instantiate()
	reflection.add_child(shadow)
	reflection.move_child(shadow, 0)
