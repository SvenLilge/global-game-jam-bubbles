extends "res://code/game_states/game_state.gd" 

#@onready var title_stream = load("res://resources/final_music/Music/Title v2.ogg");
@onready var music_player = get_parent().music_player;

func _ready():
	super._ready();
	#music_player.stream = title_stream;
	#music_player.play();


func _input(event):
	if event is InputEventKey and StateDelayTimer.time_left == 0:
		#if music_player.stream == title_stream:
		#	music_player.stop();
		sgn_transition_state.emit(State.MAIN_MENU);
	if event is InputEventMouseButton and StateDelayTimer.time_left == 0:
		#if music_player.stream == title_stream:
		#	music_player.stop();
		sgn_transition_state.emit(State.MAIN_MENU);
