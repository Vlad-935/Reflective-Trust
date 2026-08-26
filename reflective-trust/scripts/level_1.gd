extends Node2D

const REFLECTION_MULTIPLIER = Vector2(-1,1)

@onready var Nodes: Node2D = $Objects

func _ready() -> void:
	_duplicate_children()


func _duplicate_children():
	for child in Nodes.get_children():
		var path = child.get_scene_file_path() 
		var scene = load(path)
		
		var new_child = scene.instantiate()
		Nodes.add_child(new_child)
		
		_mirrored_setup(new_child, child)

func _mirrored_setup(new_child, child):
	new_child.is_mirrored = true
	
	new_child.position = child.position * REFLECTION_MULTIPLIER
	new_child.move_multiplier = Vector2(1,-1)
