extends Node2D

var hand = preload("res://assests/sprites/Cursor/Cursor - Base.png")
var click = preload("res://assests/sprites/Cursor/Cursor - Click.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(hand)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			Input.set_custom_mouse_cursor(click)
		else:
			Input.set_custom_mouse_cursor(hand)
