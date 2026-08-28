extends Node

const FADE_DURATION = 1

const FULL_BLACK = Color(0.0, 0.0, 0.0, 1.0)
const TRANSPARENT = Color(0.0, 0.0, 0.0, 0.0)

var Background: ColorRect
var loading_screen: CanvasLayer
@onready var loading_scene: PackedScene = preload("res://scenes/ui/loading.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loading_screen = loading_scene.instantiate()
	get_tree().root.add_child.call_deferred(loading_screen)
	
	Background = loading_screen.get_node("CenterContainer").get_node("ColorRect")
	fade_out()


func fade_in():
	loading_screen.show()
	var tween = create_tween()
	tween = tween.tween_property(Background, "color", FULL_BLACK, FADE_DURATION)

	await get_tree().create_timer(FADE_DURATION).timeout

func fade_out():
	var tween = create_tween()
	tween = tween.tween_property(Background, "color", TRANSPARENT, FADE_DURATION)
	
	await get_tree().create_timer(FADE_DURATION).timeout
	loading_screen.hide()
