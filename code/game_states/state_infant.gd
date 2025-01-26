extends "res://code/game_states/game_state.gd" 

@onready var player = get_parent().player;

func _ready():
	super._ready();
	player.show();
	hud.show()
	return;	
