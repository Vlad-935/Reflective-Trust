extends VBoxContainer


@onready var Master_Slider: HSlider = $Master/HSlider
@onready var Music_Slider: HSlider = $Music/HSlider
@onready var Sound_Slider: HSlider = $Sound/HSlider

@onready var Fullscreen_Check: CheckBox = $Fullscreen/CheckBox
@onready var Resolution_Option: OptionButton = $Resolution/OptionButton


func _ready() -> void:
	_populate_resolution_options()
	
	Master_Slider.value_changed.connect(_on_master_changed)
	Music_Slider.value_changed.connect(_on_music_changed)
	Sound_Slider.value_changed.connect(_on_sound_changed)
	
	Fullscreen_Check.toggled.connect(_on_fullscreen_toggled)
	Resolution_Option.item_selected.connect(_on_resolution_selected)
	
	_refresh_sliders()
	visibility_changed.connect(_refresh_sliders)


func _populate_resolution_options():
	Resolution_Option.clear()
	for resolution in DisplayManager.available_resolutions:
		Resolution_Option.add_item(str(resolution.x) + "x" + str(resolution.y))

func _refresh_sliders():
	if not visible:
		return
		
	Master_Slider.value = AudioManager.master_volume
	Music_Slider.value = AudioManager.music_volume
	Sound_Slider.value = AudioManager.sound_volume
	
	Fullscreen_Check.button_pressed = DisplayManager.is_fullscreen
	Resolution_Option.selected = DisplayManager.resolution_index
	Resolution_Option.disabled = DisplayManager.is_fullscreen


func _on_master_changed(value):
	AudioManager.set_master_volume(value)

func _on_music_changed(value):
	AudioManager.set_music_volume(value)

func _on_sound_changed(value):
	AudioManager.set_sound_volume(value)


# Fullscreen
func _on_fullscreen_toggled(toggled_on: bool) -> void:
	DisplayManager.set_fullscreen(toggled_on)
	Resolution_Option.disabled = toggled_on

# Resolution
func _on_resolution_selected(index: int) -> void:
	DisplayManager.set_resolution(index)
