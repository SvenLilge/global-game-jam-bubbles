extends "res://code/game_states/game_state.gd" 

@onready var player = get_parent().player;

var level_length = 60;

# results is: {stage: [stage_results]}
# [stage_results] is: [color] for the 1st age, [color, resources] for 2-3, [color, resources, spread_color] for 4
# might be part of player?
var game_results


func _ready():
	super._ready();
	player.show();
	hud.show()
	player.level_active = false;
	player.aura_tween.kill();
	player.influence.scale = Vector2(0,0);
	await show_tutorial(5_0)
	
	
	
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
	# results is: [[stage1_results], [stage2_results]...]
	# [stage_results] is: [color] for the 1st age, [color, resources] for 2-3, [spread_color, resources] for 4
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
	last_bubble.position = Vector2(200, 800) #add position for the infant bubble
	last_bubble.modulate.a = 0
	
	# decifer which message to play
	var col_array = results[0]
	var result_emotion = get_emotion_from_array(col_array)
	last_bubble.play_last(0, result_emotion)
	
	# float the message
	var move_to_pos = last_bubble.position + Vector2(0, -50)
	var tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)





func play_child_results(results):
	var last_bubble = text_bubble.instantiate()
	add_child(last_bubble)
	last_bubble.position = Vector2(580, 400) #add position for the infant bubble
	last_bubble.modulate.a = 0
	
	# decifer which stats message to show
	var results_array = results[1]
	var first_res = "Low_"
	var second_res = "Low"
	if results_array[0] > 15:
		first_res = "High_"
	if results_array[2] > 15:
		second_res = "High"
	last_bubble.play_last(1, first_res + second_res)
	
	# float the message
	var move_to_pos = last_bubble.position + Vector2(0, -150)
	var tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)
	await tween_modul.finished
	
	# decifer which color message to play
	var col_array = results[0]
	var result_emotion = get_emotion_from_array(col_array)
	last_bubble.play_last(1, result_emotion)
	
	# float the message
	move_to_pos = last_bubble.position + Vector2(0, -50)
	tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)


func play_teen_results(results):
	var last_bubble = text_bubble.instantiate()
	add_child(last_bubble)
	last_bubble.position = Vector2(960, 800) #add position for the infant bubble
	last_bubble.modulate.a = 0
	
	# decifer which stats message to show
	var results_array = results[1]
	var first_res = "Low_"
	var second_res = "Low"
	if results_array[0] > 45:
		first_res = "High_"
	if results_array[2] > 45:
		second_res = "High"
	last_bubble.play_last(2, first_res + second_res)
	
	# float the message
	var move_to_pos = last_bubble.position + Vector2(0, -150)
	var tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)
	await tween_modul.finished
	await get_tree().create_timer(0.6).timeout
	
	# decifer which color message to play
	var col_array = results[0]
	var result_emotion = get_emotion_from_array(col_array)
	last_bubble.play_last(2, result_emotion)
	
	# float the message
	move_to_pos = last_bubble.position + Vector2(0, -50)
	tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)


func play_ya_results(results):
	var last_bubble = text_bubble.instantiate()
	add_child(last_bubble)
	last_bubble.position = Vector2(1340, 400) #add position for the infant bubble
	last_bubble.modulate.a = 0
	
	# decifer which stats message to show
	var results_array = results[1]
	var first_res = "Low_"
	var second_res = "Low"
	if results_array[1] > 200:
		first_res = "High_"
	if results_array[2] > 120:
		second_res = "High"
	last_bubble.play_last(3, first_res + second_res)
	
	# float the message
	var move_to_pos = last_bubble.position + Vector2(0, -150)
	var tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)
	await tween_modul.finished
	await get_tree().create_timer(0.6).timeout
	
	# decifer which color message to play
	var col_array = results[0]
	var result_emotion = get_emotion_from_array(col_array)
	last_bubble.play_last(3, result_emotion)
	
	# float the message
	move_to_pos = last_bubble.position + Vector2(0, -50)
	tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)


func play_mature_results(results):
	var last_bubble = text_bubble.instantiate()
	add_child(last_bubble)
	last_bubble.position = Vector2(1720, 800) #add position for the infant bubble
	last_bubble.modulate.a = 0
	
	# decifer which stats message to show
	var results_array = results[1]
	var first_res = "Low_"
	var second_res = "Low"
	if results_array[1] > 600:
		first_res = "High_"
	if results_array[2] > 300:
		second_res = "High"
	last_bubble.play_last(4, first_res + second_res)
	
	# float the message
	var move_to_pos = last_bubble.position + Vector2(0, -150)
	var tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)
	await tween_modul.finished
	await get_tree().create_timer(0.6).timeout
	
	# decifer which color message to play
	var col_array = results[0]
	var result_emotion = get_emotion_from_array(col_array)
	last_bubble.play_last(4, result_emotion)
	
	# float the message
	move_to_pos = last_bubble.position + Vector2(0, -50)
	tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)


func get_emotion_from_array(col_array):
	var color_sum = col_array[0] + col_array[1] + col_array[2] 
	if (col_array[0] + col_array[2]) >= 0.85 * color_sum:
		return "Depressed"
	elif col_array[0] >= 0.6 * color_sum:
		return "Anger"
	elif col_array[1] >= 0.6 * color_sum:
		return "Joy"
	elif col_array[2] >= 0.6 * color_sum:
		return "Sad"
	else:
		return "Bittersweet"
