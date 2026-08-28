extends StaticBody2D

@onready var Root: Node2D = get_tree().get_root().get_node("Root")
@onready var Camera: Camera2D = Root.get_node("Camera2D")

func _on_area_2d_body_entered(body: Node2D) -> void:
	Camera.add_shake(5)
	
	# Delete Characters
	var reflection = body.get_parent().get_node("Player_Reflection")
	body = reflection.get_parent().get_node("Player")
	reflection.queue_free()
	body.queue_free()
