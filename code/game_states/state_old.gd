extends "res://code/game_states/game_state.gd" 

@onready var player = get_parent().player;

var level_length = 60;
func _ready():
	super._ready();
	player.show();
	player.level_active = false;
	
	$StageTimer.one_shot = true;
	$StageTimer.wait_time = level_length;
	$StageTimer.timeout.connect(finish_stage);
	$StageTimer.start();
	
func finish_stage():
	player.level_active = false;
	player.hide();
	player.age();
	sgn_transition_state.emit(State.MAIN_MENU);
	
