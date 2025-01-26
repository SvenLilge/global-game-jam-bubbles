extends "res://code/game_states/game_state.gd" 

@onready var player = get_parent().player;

var level_length = 45;

func _ready():
	super._ready();
	player.show();
	hud.show()
	await show_tutorial(0_0)
	
	player.level_active = false;
	
	$StageTimer.one_shot = true;
	$StageTimer.wait_time = level_length;
	$StageTimer.timeout.connect(finish_stage);
	$StageTimer.start();
	hud.start_age_counter(0)

# add these to when the 1st, 2nd and 3rd enemies are spawned:
#StageTimer.paused = true # and any other timers if relevant
#await show_tutorial(0_1) #number is for enemy number)
#StageTimer.paused = false


func finish_stage():
	player.level_active = false;
	player.hide();
	player.age();
	sgn_transition_state.emit(State.CHILD);
