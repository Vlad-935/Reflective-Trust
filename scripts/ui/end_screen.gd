extends Control

var particles
@onready var particles_scene: PackedScene = preload("res://scenes/ui/particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_timer_timeout() -> void:
	particles = particles_scene.instantiate()
	add_child(particles)
