extends CenterContainer


@onready var Sprite: Sprite2D = $Sprite2D2

var story_panel_1 = preload("res://assests/sprites/UI/Cover Image.png")
var story_panel_2 = preload("res://icon.svg")
var story_panel_3 = preload("res://assests/sprites/UI/Cover Image.png")

@onready var Player_Select: CenterContainer = $"../Player_Select"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Sprite.texture = story_panel_1
	hide()


func start_story():
	await Loading.fade_in()
	show()
	Sprite.texture = story_panel_1
	await Loading.fade_out()
	
	await get_tree().create_timer(3).timeout
	
	await Loading.fade_in()
	Sprite.texture = story_panel_2
	await Loading.fade_out()

	await get_tree().create_timer(3).timeout

	await Loading.fade_in()
	Sprite.texture = story_panel_3
	await Loading.fade_out()
	
	await get_tree().create_timer(3).timeout
	
	await Loading.fade_in()
	hide()
	Player_Select.show()
	await Loading.fade_out()
