extends "res://code/game_states/game_state.gd" 

@onready var player = get_parent().player;

var npc = preload("res://code/bubbles/npc.tscn")

var level_length = 150;
var pickup = preload("res://code/pickups/pickup.tscn")

var pickup_spawn_time = 3;

func _ready():
	super._ready();
	player.show();
	hud.show()
	player.new_stage_music(4)
	
	player.level_active = false;
	player.aura_tween.kill();
	player.influence.scale = Vector2(0,0);
	await show_tutorial(4_0)
	player.start_tween();
	player.level_active = true;
	
	spawn_bubbles();
	
	
	$StageTimer.one_shot = true;
	$StageTimer.wait_time = level_length;
	$StageTimer.timeout.connect(finish_stage);
	$StageTimer.start();
	hud.start_age_counter(4)
	
	$Area1Timer.wait_time = randf_range(pickup_spawn_time-0.5,pickup_spawn_time+0.5);
	$Area1Timer.one_shot = true;
	$Area1Timer.start();
	$Area1Timer.timeout.connect(spawn_pickup_area1);
	
	$Area2Timer.wait_time = randf_range(pickup_spawn_time-0.5,pickup_spawn_time+0.5);
	$Area2Timer.one_shot = true;
	$Area2Timer.start();
	$Area2Timer.timeout.connect(spawn_pickup_area2);
	
	$Area3Timer.wait_time = randf_range(pickup_spawn_time-0.5,pickup_spawn_time+0.5);
	$Area3Timer.one_shot = true;
	$Area3Timer.start();
	$Area3Timer.timeout.connect(spawn_pickup_area3);
	
	$Area4Timer.wait_time = randf_range(pickup_spawn_time-0.5,pickup_spawn_time+0.5);
	$Area4Timer.one_shot = true;
	$Area4Timer.start();
	$Area4Timer.timeout.connect(spawn_pickup_area4);
	
	return;

func finish_stage():
	player.level_active = false;
	player.hide();
	player.age();
	sgn_transition_state.emit(State.OLD);

func spawn_pickup_area1():
	$Area1Timer.wait_time = randf_range(pickup_spawn_time-0.5,pickup_spawn_time+0.5);
	$Area1Timer.start();
	var x_loc = randi_range($Area1Min.position.x,$Area1Max.position.x);
	var y_loc = randi_range($Area1Min.position.y,$Area1Max.position.y);
	var new_pickup = pickup.instantiate();
	new_pickup.position.x = x_loc;
	new_pickup.position.y = y_loc;
	new_pickup.set_type(Pickup.TYPE.ENERGY);
	add_child(new_pickup);
	
func spawn_pickup_area2():
	$Area2Timer.wait_time = randf_range(pickup_spawn_time-0.5,pickup_spawn_time+0.5);
	$Area2Timer.start();
	var x_loc = randi_range($Area2Min.position.x,$Area2Max.position.x);
	var y_loc = randi_range($Area2Min.position.y,$Area2Max.position.y);
	var new_pickup = pickup.instantiate();
	new_pickup.position.x = x_loc;
	new_pickup.position.y = y_loc;
	new_pickup.set_type(Pickup.TYPE.MONEY);
	add_child(new_pickup);
	
func spawn_pickup_area3():
	$Area3Timer.wait_time = randf_range(pickup_spawn_time-0.5,pickup_spawn_time+0.5);
	$Area3Timer.start();
	var x_loc = randi_range($Area3Min.position.x,$Area3Max.position.x);
	var y_loc = randi_range($Area3Min.position.y,$Area3Max.position.y);
	var new_pickup = pickup.instantiate();
	new_pickup.position.x = x_loc;
	new_pickup.position.y = y_loc;
	new_pickup.set_type(Pickup.TYPE.ENTERTAINMENT);
	add_child(new_pickup);
	
func spawn_pickup_area4():
	$Area4Timer.wait_time = randf_range(pickup_spawn_time-0.5,pickup_spawn_time+0.5);
	$Area4Timer.start();
	var x_loc = randi_range($Area4Min.position.x,$Area4Max.position.x);
	var y_loc = randi_range($Area4Min.position.y,$Area4Max.position.y);
	var new_pickup = pickup.instantiate();
	new_pickup.position.x = x_loc;
	new_pickup.position.y = y_loc;
	new_pickup.set_type(Pickup.TYPE.PERSONAL);
	add_child(new_pickup);
	

func spawn_bubbles():
	# HOME (Area 1)
	var colors = [];
	
	
	var friend = npc.instantiate();
	colors = [];
	colors.append(Color(0,1,0));
	colors.append(Color(0,1,0));
	colors.append(Color(0,1,0));
	colors.append(Color(0,1,0));
	friend.set_age_state(Bubble.AGE.MATURE,colors)
	friend.emotions[Bubble.EMOTION.ANGER] = 2;
	friend.emotions[Bubble.EMOTION.SADNESS] = 2;
	friend.emotions[Bubble.EMOTION.JOY] = 6;
	friend.position.x = randi_range($Area1Min.position.x,$Area1Max.position.x);
	friend.position.y = randi_range($Area1Min.position.y,$Area1Max.position.y);
	friend.min_pos = $Area1Min.position;
	friend.max_pos = $Area1Max.position;
	add_child(friend);
	
	var dog = npc.instantiate();
	colors = [];
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	dog.set_age_state(Bubble.AGE.CHILD,colors)
	dog.emotions[Bubble.EMOTION.ANGER] = 0;
	dog.emotions[Bubble.EMOTION.SADNESS] = 0;
	dog.emotions[Bubble.EMOTION.JOY] = 1000;
	dog.position.x = randi_range($Area1Min.position.x,$Area1Max.position.x);
	dog.position.y = randi_range($Area1Min.position.y,$Area1Max.position.y);
	dog.min_pos = $Area1Min.position;
	dog.max_pos = $Area1Max.position;
	add_child(dog);
	
	var baby = npc.instantiate();
	colors = [];
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	baby.set_age_state(Bubble.AGE.INFANT,colors)
	baby.emotions[Bubble.EMOTION.ANGER] = 0;
	baby.emotions[Bubble.EMOTION.SADNESS] = 0;
	baby.emotions[Bubble.EMOTION.JOY] = 0;
	baby.position.x = randi_range($Area1Min.position.x,$Area1Max.position.x);
	baby.position.y = randi_range($Area1Min.position.y,$Area1Max.position.y);
	baby.min_pos = $Area1Min.position;
	baby.max_pos = $Area1Max.position;
	add_child(baby);
	
	
	# SCHOOL (AREA 2)
	var angry_work = npc.instantiate();
	colors = [];
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	angry_work.set_age_state(Bubble.AGE.MATURE,colors)
	angry_work.emotions[Bubble.EMOTION.ANGER] = 8;
	angry_work.emotions[Bubble.EMOTION.SADNESS] = 1;
	angry_work.emotions[Bubble.EMOTION.JOY] = 1;
	angry_work.position.x = randi_range($Area2Min.position.x,$Area2Max.position.x);
	angry_work.position.y = randi_range($Area2Min.position.y,$Area2Max.position.y);
	angry_work.min_pos = $Area2Min.position;
	angry_work.max_pos = $Area2Max.position;
	add_child(angry_work);
	
	var joy_work = npc.instantiate();
	colors = [];
	colors.append(Color(0,1,0));
	colors.append(Color(0,1,0));
	colors.append(Color(0,1,0));
	colors.append(Color(0,1,0));
	joy_work.set_age_state(Bubble.AGE.MATURE,colors)
	joy_work.emotions[Bubble.EMOTION.ANGER] = 3;
	joy_work.emotions[Bubble.EMOTION.SADNESS] = 3;
	joy_work.emotions[Bubble.EMOTION.JOY] = 4;
	joy_work.position.x = randi_range($Area2Min.position.x,$Area2Max.position.x);
	joy_work.position.y = randi_range($Area2Min.position.y,$Area2Max.position.y);
	joy_work.min_pos = $Area2Min.position;
	joy_work.max_pos = $Area2Max.position;
	add_child(joy_work);
	
	var sad_work = npc.instantiate();
	colors = [];
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	sad_work.set_age_state(Bubble.AGE.MATURE,colors)
	sad_work.emotions[Bubble.EMOTION.ANGER] = 3;
	sad_work.emotions[Bubble.EMOTION.SADNESS] = 5;
	sad_work.emotions[Bubble.EMOTION.JOY] = 2;
	sad_work.position.x = randi_range($Area2Min.position.x,$Area2Max.position.x);
	sad_work.position.y = randi_range($Area2Min.position.y,$Area2Max.position.y);
	sad_work.min_pos = $Area2Min.position;
	sad_work.max_pos = $Area2Max.position;
	add_child(sad_work);
	
	# AREA 3 Backyard
	var fun_dude = npc.instantiate();
	colors = [];
	colors.append(Color(0,1,0));
	colors.append(Color(0,1,0));
	colors.append(Color(0,1,0));
	colors.append(Color(0,1,0));
	fun_dude.set_age_state(Bubble.AGE.MATURE,colors)
	fun_dude.emotions[Bubble.EMOTION.ANGER] = 3;
	fun_dude.emotions[Bubble.EMOTION.SADNESS] = 0;
	fun_dude.emotions[Bubble.EMOTION.JOY] = 7;
	fun_dude.position.x = randi_range($Area3Min.position.x,$Area3Max.position.x);
	fun_dude.position.y = randi_range($Area3Min.position.y,$Area3Max.position.y);
	fun_dude.min_pos = $Area3Min.position;
	fun_dude.max_pos = $Area3Max.position;
	add_child(fun_dude);
	
	var sad_dude = npc.instantiate();
	colors = [];
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	sad_dude.set_age_state(Bubble.AGE.MATURE,colors)
	sad_dude.emotions[Bubble.EMOTION.ANGER] = 0;
	sad_dude.emotions[Bubble.EMOTION.SADNESS] = 7;
	sad_dude.emotions[Bubble.EMOTION.JOY] = 3;
	sad_dude.position.x = randi_range($Area3Min.position.x,$Area3Max.position.x);
	sad_dude.position.y = randi_range($Area3Min.position.y,$Area3Max.position.y);
	sad_dude.min_pos = $Area3Min.position;
	sad_dude.max_pos = $Area3Max.position;
	add_child(sad_dude);
	
	var angry_dude = npc.instantiate();
	colors = [];
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	angry_dude.set_age_state(Bubble.AGE.MATURE,colors)
	angry_dude.emotions[Bubble.EMOTION.ANGER] = 7;
	angry_dude.emotions[Bubble.EMOTION.SADNESS] = 3;
	angry_dude.emotions[Bubble.EMOTION.JOY] = 0;
	angry_dude.position.x = randi_range($Area3Min.position.x,$Area3Max.position.x);
	angry_dude.position.y = randi_range($Area3Min.position.y,$Area3Max.position.y);
	angry_dude.min_pos = $Area3Min.position;
	angry_dude.max_pos = $Area3Max.position;
	add_child(angry_dude);
	
	
	
	# AREA 4 FRIEND
	var rando_1 = npc.instantiate();
	colors = [];
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	rando_1.set_age_state(Bubble.AGE.YA,colors)
	rando_1.emotions[Bubble.EMOTION.ANGER] = 2;
	rando_1.emotions[Bubble.EMOTION.SADNESS] = 4;
	rando_1.emotions[Bubble.EMOTION.JOY] = 4;
	rando_1.position.x = randi_range($Area4Min.position.x,$Area4Max.position.x);
	rando_1.position.y = randi_range($Area4Min.position.y,$Area4Max.position.y);
	rando_1.min_pos = $Area4Min.position;
	rando_1.max_pos = $Area4Max.position;
	add_child(rando_1);
	
	var rando_2 = npc.instantiate();
	colors = [];
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	rando_2.set_age_state(Bubble.AGE.YA,colors)
	rando_2.emotions[Bubble.EMOTION.ANGER] = 5;
	rando_2.emotions[Bubble.EMOTION.SADNESS] = 5;
	rando_2.emotions[Bubble.EMOTION.JOY] = 0;
	rando_2.position.x = randi_range($Area4Min.position.x,$Area4Max.position.x);
	rando_2.position.y = randi_range($Area4Min.position.y,$Area4Max.position.y);
	rando_2.min_pos = $Area4Min.position;
	rando_2.max_pos = $Area4Max.position;
	add_child(rando_2);
	
	var rando_3 = npc.instantiate();
	colors = [];
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	rando_3.set_age_state(Bubble.AGE.YA,colors)
	rando_3.emotions[Bubble.EMOTION.ANGER] = 4;
	rando_3.emotions[Bubble.EMOTION.SADNESS] = 2;
	rando_3.emotions[Bubble.EMOTION.JOY] = 4;
	rando_3.position.x = randi_range($Area4Min.position.x,$Area4Max.position.x);
	rando_3.position.y = randi_range($Area4Min.position.y,$Area4Max.position.y);
	rando_3.min_pos = $Area4Min.position;
	rando_3.max_pos = $Area4Max.position;
	add_child(rando_3);
	
	var rando_4 = npc.instantiate();
	colors = [];
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	rando_4.set_age_state(Bubble.AGE.YA,colors)
	rando_4.emotions[Bubble.EMOTION.ANGER] = 1;
	rando_4.emotions[Bubble.EMOTION.SADNESS] = 7;
	rando_4.emotions[Bubble.EMOTION.JOY] = 2;
	rando_4.position.x = randi_range($Area4Min.position.x,$Area4Max.position.x);
	rando_4.position.y = randi_range($Area4Min.position.y,$Area4Max.position.y);
	rando_4.min_pos = $Area4Min.position;
	rando_4.max_pos = $Area4Max.position;
	add_child(rando_4);
	
