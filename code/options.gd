extends CanvasLayer

# temporary settings altered
var sfx
var music
var st_music
var em_music
var loc_music

@onready var fadebcg = $Fade

# toggles and knobs
@onready var music_slider = $Background/BigCont/OptionsHolder/Music/Bar
@onready var sfx_slider = $Background/BigCont/OptionsHolder/SFX/Bar
@onready var stage_slider = $Background/BigCont/OptionsHolder/Music/Detailed/Stage/Bar
@onready var emotion_slider = $Background/BigCont/OptionsHolder/Music/Detailed/Emotion/Bar
@onready var location_slider = $Background/BigCont/OptionsHolder/Music/Detailed/Location/Bar

@onready var sound_player = $AudioStreamPlayer
var sound_loop = true

@onready var canc_but = $Background/BigCont/MainButtons/Cancel

var called_screen = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	# set effects to the global
	sfx = Config.sfx
	music = Config.music
	st_music = Config.st_music
	em_music = Config.em_music
	loc_music = Config.loc_music
	
	#to set them to global vars
	set_all_settings()


func _unhandled_input(_event: InputEvent) -> void:
	get_viewport().set_input_as_handled()


func set_all_sliders():
	#set music sliders
	sfx_slider.set_value_no_signal(sfx)
	music_slider.set_value_no_signal(music)
	stage_slider.set_value_no_signal(st_music)
	emotion_slider.set_value_no_signal(em_music)
	location_slider.set_value_no_signal(loc_music)
	

func set_all_settings():
	Config.set_sfx(sfx)
	Config.set_music(music)
	Config.set_st_music(st_music)
	Config.set_em_music(em_music)
	Config.set_loc_music(loc_music)
	
	set_all_sliders()


func _on_ok_pressed() -> void:
	"""
	Sets current settings to global, closes screen
	"""
	sound_player.play()
	
	# return to previous global values
	Config.sfx = sfx
	Config.music = music
	Config.st_music = st_music
	Config.em_music = em_music
	Config.loc_music = loc_music
	
	await set_all_settings()
	await Config.save_config()
	
	# close settings
	get_tree().paused = false
	queue_free()


func _on_reset_pressed() -> void:
	sound_player.play()
	
	# Set variables to reset
	sfx = Config.reset_sfx
	music = Config.reset_music
	st_music = Config.reset_st_music
	em_music = Config.reset_em_music
	loc_music = Config.reset_loc_music
	
	# change settings
	await set_all_settings()
	sound_loop = false


func _on_cancel_pressed() -> void:
	sound_player.play()
	
	# return to previous global values
	sfx = Config.sfx
	music = Config.music
	st_music = Config.st_music
	em_music = Config.em_music
	loc_music = Config.loc_music
	
	# change settings
	await set_all_settings()
	
	# close settings
	get_tree().paused = false
	queue_free()


func _on_music_value_changed(value: float) -> void:
	music = value
	Config.set_music(music)


func _on_sfx_value_changed(value: float) -> void:
	sfx = value
	Config.set_sfx(sfx)


func _on_sfx_drag_started() -> void:
	# for scrollers - to avoid overdoing
	sound_loop = true
	sound_player.play()


func _on_sfx_drag_ended(_value_changed: bool) -> void:
	sound_loop = false


func _on_title_pressed() -> void:
	sound_player.play()
	get_tree().paused = false
	if called_screen:
		called_screen.sgn_transition_state.emit(GameState.State.MAIN_MENU)


func _on_stage_value_changed(value: float) -> void:
	st_music = value
	Config.set_st_music(st_music)


func _on_emot_value_changed(value: float) -> void:
	em_music = value
	Config.set_em_music(em_music)


func _on_loc_value_changed(value: float) -> void:
	loc_music = value
	Config.set_loc_music(loc_music)


func _on_audio_stream_player_finished() -> void:
	if sound_loop:
		sound_player.play()
