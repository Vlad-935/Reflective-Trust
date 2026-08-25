extends VBoxContainer


# Fullscreen
func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


# Resolution
func _on_option_button_item_selected(index: int) -> void:
	var width: Array = [1920, 1280, 720]
	var height: Array = [1080, 720, 480]
	
	var resolution: Vector2 = Vector2(width[index], height[index])
	
	DisplayServer.window_set_size(resolution)
