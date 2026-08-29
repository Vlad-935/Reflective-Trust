extends Node

var current_level: int = 1
var is_changing_level: bool = false
var is_restarting: bool = false

var level_path: String = "res://scenes/levels/level_"

@onready var Root: Node2D = get_parent().get_node("Root")

func restart_level():
	if is_restarting:
		return
	
	is_restarting = true
	change_scene()
	
	await get_tree().create_timer(2).timeout
	is_restarting = false


func change_level():
	if is_changing_level:
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


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset level"):
		restart_level()
	
	if event.is_action_pressed("ui_accept"):
		change_level()
	
