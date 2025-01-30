extends Node2D
class_name GameState

enum State {SPLASH_SCREEN, MAIN_MENU, TUTORIAL, INFANT, CHILD, TEEN, YA, MATURE, OLD, QUIT_GAME = -1}

signal sgn_transition_state(next_state);

var StateDelayTimer = Timer.new();
var state_delay_time = 0.5;

@onready var hud = get_parent().hud;
@onready var text_bubble = load("res://code/text_bubbles/text_bubble.tscn")

func _ready():
	add_child(StateDelayTimer);
	StateDelayTimer.wait_time = state_delay_time;
	StateDelayTimer.one_shot = true;
	StateDelayTimer.start();


func show_tutorial(code, show_pos = Vector2(960, 540)):
	var tut_bubble = text_bubble.instantiate()
	add_child(tut_bubble)
	tut_bubble.position = show_pos
	tut_bubble.play_tutorial(code)
	await tut_bubble.message_finished
