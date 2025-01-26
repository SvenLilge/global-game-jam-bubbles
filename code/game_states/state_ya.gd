extends "res://code/game_states/game_state.gd" 

@onready var player = get_parent().player;

var level_length = 210;
var pickup = preload("res://code/pickups/pickup.tscn")

var pickup_spawn_time = 2.5;

func _ready():
	super._ready();
	player.show();
	hud.show()
	await show_tutorial(3_0)
	
	player.level_active = true;
	
	$StageTimer.one_shot = true;
	$StageTimer.wait_time = level_length;
	$StageTimer.timeout.connect(finish_stage);
	$StageTimer.start();
	hud.start_age_counter(3)
	
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
	sgn_transition_state.emit(State.MATURE);

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
	new_pickup.set_type(Pickup.TYPE.ENTERTAINMENT);
	add_child(new_pickup);
	
func spawn_pickup_area3():
	$Area3Timer.wait_time = randf_range(pickup_spawn_time-0.5,pickup_spawn_time+0.5);
	$Area3Timer.start();
	var x_loc = randi_range($Area3Min.position.x,$Area3Max.position.x);
	var y_loc = randi_range($Area3Min.position.y,$Area3Max.position.y);
	var new_pickup = pickup.instantiate();
	new_pickup.position.x = x_loc;
	new_pickup.position.y = y_loc;
	new_pickup.set_type(Pickup.TYPE.EDUCATION);
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
