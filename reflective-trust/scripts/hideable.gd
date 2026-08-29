extends Node

var shadows_overlap: int = 0

@onready var Sprite: Sprite2D = get_parent().get_node("Sprite2D")

func hide_by_shadow():
	shadows_overlap += 1
	update_visibility()

func show_by_shadow():
	shadows_overlap -= 1
	update_visibility()


func update_visibility():
	if shadows_overlap > 0:
		Sprite.hide()
	else:
		Sprite.show()
