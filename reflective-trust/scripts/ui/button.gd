extends Button

@onready var Select_Sound: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _on_pressed() -> void:
	Select_Sound.play(0.2)
