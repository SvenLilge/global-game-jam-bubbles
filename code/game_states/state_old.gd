extends "res://code/game_states/game_state.gd" 

@onready var player = get_parent().player;

var level_length = 600;

# results is: {stage: [stage_results]}
# [stage_results] is: [color] for the 1st age, [color, resources] for 2-3, [color, resources, spread_color] for 4
# might be part of player?
var game_results


func _ready():
	super._ready();
	player.show();
	hud.show()
	await show_tutorial(5_0)
	
	player.level_active = false;
	
	$StageTimer.one_shot = true;
	$StageTimer.wait_time = level_length;
	$StageTimer.timeout.connect(finish_stage);
	$StageTimer.start();
	hud.start_age_counter(5)
	
	play_inf_results(null)
	
func finish_stage():
	player.level_active = false;
	player.hide();
	player.age();
	sgn_transition_state.emit(State.MAIN_MENU);
	

func play_last_stage(num, results):
	# results is: {stage: [stage_results]}
	# [stage_results] is: [color] for the 1st age, [color, resources] for 2-3, [color, resources, spread_color] for 4
	match num:
		0:
			play_inf_results(results[0])
		1:
			play_child_results(results[1])
		2:
			play_teen_results(results[2])
		3:
			play_ya_results(results[3])
		4:
			play_mature_results(results[4])


func play_inf_results(results):
	var last_bubble = text_bubble.instantiate()
	add_child(last_bubble)
	last_bubble.position = Vector2(200, 500) #add position for the infant bubble
	last_bubble.modulate.a = 0
	
	# decifer which message to play
	var main_color = results.max()
	last_bubble.play_last("Joy")
	
	# float the message
	var move_to_pos = last_bubble.position + Vector2(0, -50)
	var tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)


func play_child_results(results):
	pass


func play_teen_results(results):
	pass


func play_ya_results(results):
	pass


func play_mature_results(results):
	pass
