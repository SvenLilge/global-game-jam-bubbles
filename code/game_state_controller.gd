extends Node2D

signal transition_finished

# This node handles the transition between all possible (high-level) game states
var cur_game_state; 

# We will also keep a reference of all other possible states to cleanly transition between them
var game_states: Array[PackedScene]

@onready var music_player = $MusicPlayer;
@onready var player = $Player;

@onready var hud = $HUD

#@onready var background_stream = load("res://resources/final_music/Music/Between stages v3.ogg");
#@onready var title_stream = load("res://resources/final_music/Music/Title v2.ogg");


func _ready():
	# Create array of states
	# Loops from 0 to number of game states (skips last element, which is QUIT_GAME)
	for n in GameState.State.values().size() - 1:
		#This automatically detects all the possible game states defined in the GameState class
		# It then aims to load the corresponding state and store it in an array 
		# We can then easily instantiate objects in this array on the fly
		# The index of each state corresponds to the enum defined in GameState
		# This makes life a bit easier for us, as we don't hard code loading every scene we define
		# We just need to make sure the file exists and we added to the enum list 
		var filename = "res://code/game_states/state_" + GameState.State.keys()[n].to_lower() + ".tscn"
		game_states.append(load(filename))
	# Load Splash Screen as the current scene
	cur_game_state = game_states[GameState.State.MAIN_MENU].instantiate();
	add_child(cur_game_state); # add to scene
	cur_game_state.sgn_transition_state.connect(transition_game_state.bind());
	
	#$Player.hide();
	#hud.hide()
	
	$Player.set_hud()
	#music_player.stream = title_stream;
	#music_player.play();

func _process(_delta):
	if not music_player.playing:
		reset_music_player();
	return;

func reset_music_player():
	#music_player.stream = background_stream;
	music_player.play();
	return;

func transition_game_state(next_state):
	if next_state == GameState.State.QUIT_GAME:
		get_tree().quit();
	else:
		var tween_modul = get_tree().create_tween()
		tween_modul.tween_property(self, "modulate", Color(1,1,1,0), 1.5).set_trans(Tween.TRANS_SINE)
		await tween_modul.finished
		cur_game_state.queue_free() # Delete old scene
		await get_tree().create_timer(2.0).timeout
		
		# Reset the music player
		# Load in new scene1
		cur_game_state = game_states[next_state].instantiate();
		# Probably need some other mechanic to carry over data as well (will figure out along the way)
		add_child(cur_game_state); # add to scene
		cur_game_state.sgn_transition_state.connect(transition_game_state.bind()) # Connect signal
		tween_modul = get_tree().create_tween()
		tween_modul.tween_property(self, "modulate", Color(1,1,1,1), 1.5).set_trans(Tween.TRANS_SINE)
		transition_finished.emit()
		
