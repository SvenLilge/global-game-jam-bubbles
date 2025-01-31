extends "res://code/game_states/game_state.gd" 


func _ready() -> void:
	super._ready()
	get_parent().restart_game()


func _on_new_game_pressed() -> void:
	sgn_transition_state.emit(State.INFANT)


func _on_option_pressed() -> void:
	var opt_screen = load("res://code/options.tscn").instantiate()
	add_child(opt_screen)
	opt_screen.called_screen = self
