extends Node

var master_volume: float = 1.0
var music_volume: float = 1.0
var sound_volume: float = 1.0

func _ready() -> void:
	set_master_volume(master_volume)
	set_music_volume(music_volume)
	set_sound_volume(sound_volume)


func set_master_volume(value):
	master_volume = value
	set_bus_volume("Master", master_volume)

func set_music_volume(value):
	music_volume = value
	set_bus_volume("Music", music_volume)

func set_sound_volume(value):
	sound_volume = value
	set_bus_volume("Sound", sound_volume)


func set_bus_volume(bus_name, value):
	var bus_index = AudioServer.get_bus_index(bus_name)
	var db = linear_to_db(value)
	if value <= 0.0:
		db = -80.0
	
	AudioServer.set_bus_volume_db(bus_index, db)
