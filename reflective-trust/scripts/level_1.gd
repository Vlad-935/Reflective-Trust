extends Node2D

const REFLECTION_MULTIPLIER = Vector2(-1,1)

@onready var Objects: Node2D = $Objects
@onready var Spikes: Node2D = $Spikes
@onready var Doors: Node2D = $Doors
@onready var Walls: Node2D = $Walls

@onready var Shadow_Scene: PackedScene = preload("res://scenes/shadow.tscn")

func _ready() -> void:
	_duplicate_objects(Objects, true)
	_duplicate_objects(Spikes, false)
	_duplicate_objects(Doors, false)
	_duplicate_objects(Walls, true)

func _duplicate_objects(folder, add_shadow):
	for child in folder.get_children():
		var path = child.get_scene_file_path() 
		var scene = load(path)
		
		var new_child = scene.instantiate()
		folder.add_child(new_child)
		
		_mirrored_setup(new_child, child, add_shadow)

func _mirrored_setup(reflection, child, add_shadow):
	reflection.is_mirrored = true
	
	# Sprite
	reflection.find_child("Sprite2D").flip_h = true
	
	# Position Reflection
	reflection.position = child.position * REFLECTION_MULTIPLIER
	reflection.move_multiplier = Vector2(1,-1)
	
	# Add Shadow
	if add_shadow:
		var shadow = Shadow_Scene.instantiate()
		reflection.add_child(shadow)
		reflection.move_child(shadow, 0)
