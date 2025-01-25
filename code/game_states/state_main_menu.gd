extends "res://code/game_states/game_state.gd" 

func _input(event):
	if event is InputEventKey and StateDelayTimer.time_left == 0:
		match event.key_label:
			KEY_1: sgn_transition_state.emit(State.INFANT);
			KEY_2: sgn_transition_state.emit(State.QUIT_GAME);
