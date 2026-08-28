extends Node

var current_level: int = 0

var level_path: String = "res://scenes/levels/level_"

func change_level():
	var level = get_node("Level_root")
	var new_level = load(level_path + str(current_level) + ".tscn")
	
	await Loading.fade_in()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		change_level()
