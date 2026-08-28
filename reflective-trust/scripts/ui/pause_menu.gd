extends Control

var is_in_options: bool = false

@onready var PausedButtons: VBoxContainer = $CenterContainer/PausedButtons
@onready var OptionsButtons: VBoxContainer = $CenterContainer/OptionsButtons

func _ready() -> void:
	_hide_options()
	_resume_game()

func _pause_game():
	get_tree().paused = true
	show()


func _resume_game():
	get_tree().paused = false
	hide()


func _show_options():
	PausedButtons.hide()
	OptionsButtons.show()


func _hide_options():
	PausedButtons.show()
	OptionsButtons.hide()


func _input(event: InputEvent) -> void:
	if not DisplayManager.can_be_paused:
		return
	
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			if is_in_options:
				_on_back_pressed()
			else:
				_resume_game()
		
		else:
			_pause_game()


func _on_resume_pressed() -> void:
	_resume_game()


func _on_options_pressed() -> void:
	is_in_options = true
	_show_options()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	is_in_options = false
	_hide_options()
