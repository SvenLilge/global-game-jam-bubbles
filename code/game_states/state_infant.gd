extends "res://code/game_states/game_state.gd" 

var npc = preload("res://code/bubbles/npc.tscn")

@onready var player = get_parent().player;

var level_length = 30; #30

var anger_bubble = null;
var joy_bubble = null;
var sad_bubble = null;

var spawn1 = false;
var spawn2 = false;
var spawn3 = false;

func _ready():
	super._ready();
	player.show();
	player.new_stage_music(0)
	
	player.level_active = false;
	player.aura_tween.kill();
	player.influence.scale = Vector2(0,0);
	player.tween_timer.stop();
	player.position = Vector2(1920.0/2,1080.0/2)
	await get_parent().transition_finished
	await show_tutorial(0_0)
	player.level_active = true;
	
	
	$StageTimer.one_shot = true;
	$StageTimer.wait_time = level_length;
	$StageTimer.timeout.connect(finish_stage);
	$StageTimer.start();
	hud.start_age_counter(0)
	hud.show()

# add these to when the 1st, 2nd and 3rd enemies are spawned:
#StageTimer.paused = true # and any other timers if relevant
#await show_tutorial(0_1) #number is for enemy number)
#StageTimer.paused = false

func _process(delta: float) -> void:
	if $StageTimer.is_stopped() == false:
		var current_time = level_length - $StageTimer.time_left;
		if current_time >= 3:
			if spawn1 == false:
				# Spawn first bubble
				spawn_first_bubble();
		if current_time >= 10:
			if joy_bubble != null:
				remove_child(joy_bubble);
				joy_bubble = null;
		if current_time >= 13:
			if spawn2 == false:
				# Spawn first bubble
				spawn_second_bubble();
		if current_time >= 20:
			if anger_bubble != null:
				remove_child(anger_bubble);
				anger_bubble = null;
		if current_time >= 23:
			if spawn3 == false:
				# Spawn first bubble
				spawn_third_bubble();
		if current_time >= 29.5:
			if sad_bubble != null:
				remove_child(sad_bubble);
				sad_bubble = null;

func spawn_first_bubble():
	
	player.level_active = false;
	
	$StageTimer.paused = true;
	spawn1 = true;
	joy_bubble = npc.instantiate();
	var colors = [];
	colors.append(Color(0,1,0));
	colors.append(Color(0,1,0));
	colors.append(Color(0,1,0));
	colors.append(Color(0,1,0));
	joy_bubble.set_age_state(Bubble.AGE.MATURE,colors)
	joy_bubble.emotions[Bubble.EMOTION.JOY] = 10;
	joy_bubble.position.x = 1920.0/2;
	joy_bubble.position.y = 1080.0/2 + 300;
	joy_bubble.bubble_class = Bubble.BUB_CLASS.RELATIVE;
	add_child(joy_bubble);
	
	joy_bubble.speed = 0
	hud.pause_age_counter()
	await show_tutorial(0_1, Vector2(960, 840));
	hud.pause_age_counter(false)
	joy_bubble.speed = 0.75*joy_bubble.base_speed
	
	$StageTimer.paused = false;
	
	player.level_active = true;

func spawn_second_bubble():
	
	player.level_active = false;
	$StageTimer.paused = true;
	spawn2 = true;
	
	anger_bubble = npc.instantiate();
	var colors = [];
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	colors.append(Color(1,0,0));
	anger_bubble.set_age_state(Bubble.AGE.MATURE,colors)
	anger_bubble.emotions[Bubble.EMOTION.ANGER] = 10;
	anger_bubble.position.x = 1920.0/2 - 200;
	anger_bubble.position.y = 1080.0/2 - 200;
	anger_bubble.bubble_class = Bubble.BUB_CLASS.RELATIVE;
	add_child(anger_bubble);
	
	anger_bubble.speed = 0
	hud.pause_age_counter()
	await show_tutorial(0_2, Vector2(760, 340));
	hud.pause_age_counter(false)
	anger_bubble.speed = 0.75*anger_bubble.base_speed
	
	$StageTimer.paused = false;
	
	player.level_active = true;
	
func spawn_third_bubble():
	player.level_active = false;
	$StageTimer.paused = true;
	spawn3 = true;
	
	sad_bubble = npc.instantiate();
	var colors = [];
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	colors.append(Color(0,0,1));
	sad_bubble.set_age_state(Bubble.AGE.MATURE,colors)
	sad_bubble.emotions[Bubble.EMOTION.SADNESS] = 10;
	sad_bubble.position.x = 1920.0/2 + 200;
	sad_bubble.position.y = 1080.0/2 - 200;
	sad_bubble.bubble_class = Bubble.BUB_CLASS.RELATIVE;
	add_child(sad_bubble);
	
	sad_bubble.speed = 0
	hud.pause_age_counter()
	await show_tutorial(0_3, Vector2(1160, 340));
	hud.pause_age_counter(false)
	sad_bubble.speed = 0.75*sad_bubble.base_speed
	
	$StageTimer.paused = false;
	player.level_active = true;

func finish_stage():
	player.level_active = false;
	player.hide();
	player.age();
	sgn_transition_state.emit(State.CHILD);
