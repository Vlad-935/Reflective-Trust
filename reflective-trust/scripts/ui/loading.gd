extends Control

const FADE_DURATION = 1

const FULL_BLACK = Color(0.0, 0.0, 0.0, 1.0)
const TRANSPARENT = Color(0.0, 0.0, 0.0, 0.0)

@onready var Background: ColorRect = $CenterContainer/ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Background.color = Color(0.0, 0.0, 0.0, 1.0)
	fade_out()


func fade_in():
	var tween = create_tween()
	tween = tween.tween_property(Background, "color", FULL_BLACK, FADE_DURATION)

	await get_tree().create_timer(FADE_DURATION).timeout

func fade_out():
	var tween = create_tween()
	tween = tween.tween_property(Background, "color", TRANSPARENT, FADE_DURATION)
	
	await get_tree().create_timer(FADE_DURATION).timeout
