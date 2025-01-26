extends Node2D
class_name GameState

enum State {SPLASH_SCREEN, MAIN_MENU, TUTORIAL, INFANT, CHILD, TEEN, YA, MATURE, OLD, QUIT_GAME = -1}

signal sgn_transition_state(next_state);

var StateDelayTimer = Timer.new();
var state_delay_time = 0.5;

@onready var hud = get_parent().hud;

func _ready():
	add_child(StateDelayTimer);
	StateDelayTimer.wait_time = state_delay_time;
	StateDelayTimer.one_shot = true;
	StateDelayTimer.start();
