extends Line2D

@onready var Moveable_Object = get_parent()
@onready var Object_Sprite: Sprite2D = Moveable_Object.get_node("Sprite2D")

@onready var BaW_Shader: Shader = preload("res://assests/shaders/black_and_white.gdshader")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == Moveable_Object:
		return
	
	if body.is_in_group("player"):
		if body.is_dead:
			return
			
		var Sprite = body.find_child("*Sprite")
		Sprite.material.set_shader_parameter("active", true)
		return
		
	body.get_node("Sprite2D").hide()
	
	# Disable Shadow
	if body.has_shadow:
		body.get_node("Shadow").get_node("Area2D").set_collision_mask_value(1, false)
	
	if body.is_in_group("moveable"):
		body.set_collision_layer_value(3, false)
	elif body.is_in_group("wall"):
		body.set_collision_layer_value(2, false)
	else:
		body.set_collision_layer_value(6, false)
		body.get_node("Area2D").set_collision_mask_value(1, false)


func _on_area_2d_body_exited(body: Node2D) -> void:
	# Change Color for Player
	if body.is_in_group("player"):
		if body.is_dead:
			return
			
		var Sprite = body.find_child("*Sprite")
		Sprite.material.set_shader_parameter("active", false)
		return
	
	body.get_node("Sprite2D").show()
	
	# Enable Shadow
	if body.has_shadow:
		body.get_node("Shadow").get_node("Area2D").set_collision_mask_value(1, true)
	
	# Enable Objects
	if body.is_in_group("moveable"):
		body.set_collision_layer_value(3, true)
	elif body.is_in_group("wall"):
		body.set_collision_layer_value(2, true)
	else:
		body.set_collision_layer_value(6, true)
		body.get_node("Area2D").set_collision_mask_value(1, true)
