extends HSlider

@export var AudioBusName: String

var audio_var_id: int

func _ready() -> void:
	audio_var_id = AudioServer.get_bus_index(AudioBusName)


func _on_value_changed(sound_value: float) -> void:
	var db: float = linear_to_db(sound_value)
	AudioServer.set_bus_volume_db(audio_var_id, db)
