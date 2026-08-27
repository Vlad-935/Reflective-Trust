extends Line2D

@onready var Moveable_Object: AnimatableBody2D = get_parent()
@onready var Object_Sprite: Sprite2D = Moveable_Object.get_node("Sprite2D")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == Moveable_Object:
		return
	
	if body.is_in_group("player"):
		return
		
	body.get_node("Sprite2D").hide()
	body.set_collision_layer_value(3, false)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		return
		
	body.get_node("Sprite2D").show()
	body.set_collision_layer_value(3, true)
