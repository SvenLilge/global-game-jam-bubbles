extends "res://code/game_states/game_state.gd" 

@onready var player = get_parent().player;

var bubble = preload("res://code/bubbles/bubble.tscn")


# results is: {stage: [stage_results]}
# [stage_results] is: [color] for the 1st age, [color, resources] for 2-3, [color, resources, spread_color] for 4
# might be part of player?
var game_results

var infant
var child
var teen
var ya
var mature

func _ready():
	super._ready();
	player.hide();
	hud.show()
	player.new_stage_music(5)
	
	player.level_active = false;
	player.aura_tween.kill();
	player.influence.scale = Vector2(0,0);
	hud.start_age_counter(5)

	var colors;

	# Spawn five bubbles
	#INFANT
	infant = bubble.instantiate();
	colors = [];
	infant.set_age_state(Bubble.AGE.INFANT,colors)
	infant.emotions[Bubble.EMOTION.ANGER] = player.age_colors[0][0];
	infant.emotions[Bubble.EMOTION.SADNESS] = player.age_colors[0][2];
	infant.emotions[Bubble.EMOTION.JOY] = player.age_colors[0][1];
	infant.position.x = 100;
	infant.position.y = 800;
	add_child(infant);
	infant.aura_tween.kill();
	infant.influence.scale = Vector2(0,0);
	infant.tween_timer.stop();
	
	# CHILD
	child = bubble.instantiate();
	colors = [];
	colors.append(Color(player.age_colors[1][0],player.age_colors[1][1],player.age_colors[1][2]));
	child.set_age_state(Bubble.AGE.CHILD,colors)
	child.emotions[Bubble.EMOTION.ANGER] = player.age_colors[1][0];
	child.emotions[Bubble.EMOTION.SADNESS] = player.age_colors[1][2];
	child.emotions[Bubble.EMOTION.JOY] = player.age_colors[1][1];
	child.position.x = 430;
	child.position.y = 400;
	add_child(child);
	child.aura_tween.kill();
	child.influence.scale = Vector2(0,0);
	child.tween_timer.stop();
	
	# TEEN
	teen = bubble.instantiate();
	colors = [];
	colors.append(Color(player.age_colors[2][0],player.age_colors[2][1],player.age_colors[2][2]));
	colors.append(Color(player.age_colors[2][0],player.age_colors[2][1],player.age_colors[2][2]));
	teen.set_age_state(Bubble.AGE.TEEN,colors)
	teen.emotions[Bubble.EMOTION.ANGER] = player.age_colors[2][0];
	teen.emotions[Bubble.EMOTION.SADNESS] = player.age_colors[2][2];
	teen.emotions[Bubble.EMOTION.JOY] = player.age_colors[2][1];
	teen.position.x = 760;
	teen.position.y = 800;
	add_child(teen);
	teen.aura_tween.kill();
	teen.influence.scale = Vector2(0,0);
	teen.tween_timer.stop();
	
	# YA
	ya = bubble.instantiate();
	colors = [];
	colors.append(Color(player.age_colors[3][0],player.age_colors[3][1],player.age_colors[3][2]));
	colors.append(Color(player.age_colors[3][0],player.age_colors[3][1],player.age_colors[3][2]));
	colors.append(Color(player.age_colors[3][0],player.age_colors[3][1],player.age_colors[3][2]));
	ya.set_age_state(Bubble.AGE.YA,colors)
	ya.emotions[Bubble.EMOTION.ANGER] = player.age_colors[3][0];
	ya.emotions[Bubble.EMOTION.SADNESS] = player.age_colors[3][2];
	ya.emotions[Bubble.EMOTION.JOY] = player.age_colors[3][1];
	ya.position.x = 1090;
	ya.position.y = 400;
	add_child(ya);
	ya.aura_tween.kill();
	ya.influence.scale = Vector2(0,0);
	ya.tween_timer.stop();
	
	# MATURE
	mature = bubble.instantiate();
	colors = [];
	colors.append(Color(player.age_colors[4][0],player.age_colors[4][1],player.age_colors[4][2]));
	colors.append(Color(player.age_colors[4][0],player.age_colors[4][1],player.age_colors[4][2]));
	colors.append(Color(player.age_colors[4][0],player.age_colors[4][1],player.age_colors[4][2]));
	colors.append(Color(player.age_colors[4][0],player.age_colors[4][1],player.age_colors[4][2]));
	mature.set_age_state(Bubble.AGE.MATURE,colors)
	mature.emotions[Bubble.EMOTION.ANGER] = player.age_colors[4][0];
	mature.emotions[Bubble.EMOTION.SADNESS] = player.age_colors[4][2];
	mature.emotions[Bubble.EMOTION.JOY] = player.age_colors[4][1];
	mature.position.x = 1420;
	mature.position.y = 800;
	add_child(mature);
	mature.aura_tween.kill();
	mature.influence.scale = Vector2(0,0);
	mature.tween_timer.stop();
	await show_tutorial(5_0)
	
func pop_infant_bubble():
	var results = [];
	results.append(player.age_colors[0]);
	results.append(player.age_resources[0]);
	print(results)
	play_last_stage(0,results);
func pop_child_bubble():
	var results = [];
	results.append(player.age_colors[1]);
	results.append(player.age_resources[1]);
	print(results)
	play_last_stage(1,results);
func pop_teen_bubble():
	var results = [];
	results.append(player.age_colors[2]);
	results.append(player.age_resources[2]);
	print(results)
	play_last_stage(2,results);
func pop_ya_bubble():
	var results = [];
	results.append(player.age_colors[3]);
	results.append(player.age_resources[3]);
	print(results)
	play_last_stage(3,results);
func pop_mature_bubble():
	var results = [];
	results.append(player.age_colors[4]);
	results.append(player.age_resources[4]);
	print(results)
	play_last_stage(4,results);

func _input(event):
	if event is InputEventMouseButton and StateDelayTimer.time_left == 0:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if infant.sprite.get_rect().has_point(infant.sprite.to_local(get_global_mouse_position())):
				pop_infant_bubble();
			if child.sprite.get_rect().has_point(child.sprite.to_local(get_global_mouse_position())):
				pop_child_bubble();
			if teen.sprite.get_rect().has_point(teen.sprite.to_local(get_global_mouse_position())):
				pop_teen_bubble();
			if ya.sprite.get_rect().has_point(ya.sprite.to_local(get_global_mouse_position())):
				pop_ya_bubble();
			if mature.sprite.get_rect().has_point(mature.sprite.to_local(get_global_mouse_position())):
				pop_mature_bubble();


func finish_stage():
	sgn_transition_state.emit(State.MAIN_MENU);
	

func play_last_stage(num, results):
	# [results] is: [color] for the 1st age, [color, resources] for 2-3, [spread_color, resources] for 4
	match num:
		0:
			play_inf_results(results)
		1:
			play_child_results(results)
		2:
			play_teen_results(results)
		3:
			play_ya_results(results)
		4:
			play_mature_results(results)


func play_inf_results(results):
	var last_bubble = text_bubble.instantiate()
	add_child(last_bubble)
	last_bubble.position = Vector2(100, 800) #add position for the infant bubble
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
	last_bubble.position = Vector2(430, 400) #add position for the infant bubble
	last_bubble.modulate.a = 0
	
	# decifer which stats message to show
	var results_array = results[1]
	var first_res = "Low_"
	var second_res = "Low"
	if results_array[0] > 15:
		first_res = "High_"
	if results_array[2] > 15:
		second_res = "High"
	last_bubble.play_last(1_1, first_res + second_res)
	
	# float the message
	var move_to_pos = last_bubble.position + Vector2(0, -200)
	var tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)
	await tween_modul.finished
	
	# decifer which color message to play
	var new_bubble = text_bubble.instantiate()
	add_child(new_bubble)
	new_bubble.position = Vector2(430, 400) #add position for the infant bubble
	new_bubble.modulate.a = 0
	var col_array = results[0]
	var result_emotion = get_emotion_from_array(col_array)
	new_bubble.play_last(1_2, result_emotion)
	
	# float the message
	move_to_pos = new_bubble.position + Vector2(0, -50)
	tween_modul = get_tree().create_tween()
	tween_modul.tween_property(new_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(new_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)


func play_teen_results(results):
	var last_bubble = text_bubble.instantiate()
	add_child(last_bubble)
	last_bubble.position = Vector2(760, 800) #add position for the infant bubble
	last_bubble.modulate.a = 0
	
	# decifer which stats message to show
	var results_array = results[1]
	var first_res = "Low_"
	var second_res = "Low"
	if results_array[0] > 45:
		first_res = "High_"
	if results_array[2] > 45:
		second_res = "High"
	last_bubble.play_last(2_1, first_res + second_res)
	
	# float the message
	var move_to_pos = last_bubble.position + Vector2(0, -200)
	var tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)
	await tween_modul.finished
	await get_tree().create_timer(0.6).timeout
	
	# decifer which color message to play
	var new_bubble = text_bubble.instantiate()
	add_child(new_bubble)
	new_bubble.position = Vector2(760, 800) #add position for the infant bubble
	new_bubble.modulate.a = 0
	var col_array = results[0]
	var result_emotion = get_emotion_from_array(col_array)
	new_bubble.play_last(2_2, result_emotion)
	
	# float the message
	move_to_pos = new_bubble.position + Vector2(0, -50)
	tween_modul = get_tree().create_tween()
	tween_modul.tween_property(new_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(new_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)


func play_ya_results(results):
	var last_bubble = text_bubble.instantiate()
	add_child(last_bubble)
	last_bubble.position = Vector2(1090, 400) #add position for the infant bubble
	last_bubble.modulate.a = 0
	
	# decifer which stats message to show
	var results_array = results[1]
	var first_res = "Low_"
	var second_res = "Low"
	if results_array[1] > 200:
		first_res = "High_"
	if results_array[2] > 120:
		second_res = "High"
	last_bubble.play_last(3_1, first_res + second_res)
	
	# float the message
	var move_to_pos = last_bubble.position + Vector2(0, -200)
	var tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)
	await tween_modul.finished
	await get_tree().create_timer(0.6).timeout
	
	# decifer which color message to play
	var new_bubble = text_bubble.instantiate()
	add_child(new_bubble)
	new_bubble.position = Vector2(1090, 400) #add position for the infant bubble
	new_bubble.modulate.a = 0
	var col_array = results[0]
	var result_emotion = get_emotion_from_array(col_array)
	new_bubble.play_last(3_2, result_emotion)
	
	# float the message
	move_to_pos = new_bubble.position + Vector2(0, -50)
	tween_modul = get_tree().create_tween()
	tween_modul.tween_property(new_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(new_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)


func play_mature_results(results):
	var last_bubble = text_bubble.instantiate()
	add_child(last_bubble)
	last_bubble.position = Vector2(1420, 800) #add position for the infant bubble
	last_bubble.modulate.a = 0
	
	# decifer which stats message to show
	var results_array = results[1]
	var first_res = "Low_"
	var second_res = "Low"
	if results_array[1] > 600:
		first_res = "High_"
	if results_array[2] > 300:
		second_res = "High"
	last_bubble.play_last(4_1, first_res + second_res)
	
	# float the message
	var move_to_pos = last_bubble.position + Vector2(0, -200)
	var tween_modul = get_tree().create_tween()
	tween_modul.tween_property(last_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(last_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)
	await tween_modul.finished
	await get_tree().create_timer(0.6).timeout
	
	# decifer which color message to play
	var new_bubble = text_bubble.instantiate()
	add_child(new_bubble)
	new_bubble.position = Vector2(1420, 800) #add position for the infant bubble
	new_bubble.modulate.a = 0
	var col_array = results[0]
	var result_emotion = get_emotion_from_array(col_array)
	new_bubble.play_last(4_2, result_emotion)
	
	# float the message
	move_to_pos = new_bubble.position + Vector2(0, -50)
	tween_modul = get_tree().create_tween()
	tween_modul.tween_property(new_bubble, "modulate:a", 1, 0.6).set_trans(Tween.TRANS_SINE)
	tween_modul.parallel().tween_property(new_bubble, "position", move_to_pos, 0.6).set_trans(Tween.TRANS_SINE)


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
