extends Node

var master_volume: float = 1.0
var music_volume: float = 1.0
var sound_volume: float = 1.0

var audio_scene

@onready var main_menu_song = preload("res://assests/audio/music/Main Menu Song.mp3")
@onready var game_song = preload("res://assests/audio/music/Density & Time - MAZE  NO COPYRIGHT 8-bit Music.mp3")
@onready var end_game_song = preload("res://assests/audio/music/End Credits Song.mp3")

@onready var Audio_Streamer: PackedScene = preload("res://scenes/music.tscn")

func _ready() -> void:
	set_master_volume(master_volume)
	set_music_volume(music_volume)
	set_sound_volume(sound_volume)

	audio_scene = Audio_Streamer.instantiate()
	add_child(audio_scene)
	audio_scene.stream = main_menu_song
	audio_scene.play()


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
