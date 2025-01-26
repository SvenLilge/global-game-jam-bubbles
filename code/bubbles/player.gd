extends Bubble

enum RES {EN, ENT, ED, P}

var deadzone_threshold_trans = 0.3;
var deadzone_threshold_rot = 0.6;
var move_dir = Vector2(0,0);


var resources = [0,0,0,0]


@onready var influence = $Influence;

func _ready():
	speed = 400;
	emotions[Bubble.EMOTION.JOY] = 100.0;
	influence_strength = 0;
	super._ready();
	
	
	$ResourceDepletionTimer.one_shot = false;
	$ResourceDepletionTimer.wait_time = 1;
	$ResourceDepletionTimer.timeout.connect(deplete_resources);
	$ResourceDepletionTimer.start();

func _physics_process(delta):
	
	print("Emotions")
	print(emotions)
	print("Resources")
	print(resources)
	
	super._physics_process(delta)

	if(get_tree().paused == true):
		return;
	
	#Handle Inputs for Motion
	var move_input = Vector2(0,0);
	if(Input.get_connected_joypads().size() > 0):
		move_input = Vector2(Input.get_joy_axis(0,JOY_AXIS_LEFT_X),Input.get_joy_axis(0,JOY_AXIS_LEFT_Y));
	else:
		var left = 0;
		var up = 0;
		if(Input.is_key_pressed(KEY_W)):
			up = 1;
		if(Input.is_key_pressed(KEY_S)):
			up = -1;
		if(Input.is_key_pressed(KEY_A)):
			left = 1;
		if(Input.is_key_pressed(KEY_D)):
			left = -1;
		move_input = Vector2(-1*left,-1*up);
		
	if(move_input.length() > deadzone_threshold_trans):
		move_dir = move_input;
	else:
		move_dir = Vector2(0,0);

	# Compute player velocity
	velocity = move_dir.normalized() * speed;
		
	# Update Player position
	move_and_slide();

func pickup_energy():
	var amount = 0;
	match cur_age:
		AGE.INFANT:
			pass
		AGE.CHILD:
			amount = 8;
		AGE.TEEN:
			amount = 5;
		AGE.YA:
			amount = 3;
		AGE.MATURE:
			amount = 2;
		AGE.OLD:
			pass
	resources[RES.EN] = resources[RES.EN] + amount;
	if resources[RES.EN] > 10:
		resources[RES.EN] = 10;

func pickup_entertainment():
	var amount = 0;
	match cur_age:
		AGE.INFANT:
			pass
		AGE.CHILD:
			amount = 8;
		AGE.TEEN:
			amount = 5;
		AGE.YA:
			amount = 3;
		AGE.MATURE:
			amount = 2;
		AGE.OLD:
			pass
	resources[RES.ENT] = resources[RES.ENT] + amount;
	if resources[RES.ENT] > 10:
		resources[RES.ENT] = 10;
		
func pickup_education_money():
	var amount = 0;
	match cur_age:
		AGE.INFANT:
			pass
		AGE.CHILD:
			amount = 8;
		AGE.TEEN:
			amount = 5;
		AGE.YA:
			amount = 3;
		AGE.MATURE:
			amount = 2;
		AGE.OLD:
			pass
	resources[RES.ED] = resources[RES.ED] + amount;
	if resources[RES.ED] > 50:
		resources[RES.ED] = 50;
		
func pickup_personal():
	var amount = 0;
	match cur_age:
		AGE.INFANT:
			pass
		AGE.CHILD:
			amount = 8;
		AGE.TEEN:
			amount = 5;
		AGE.YA:
			amount = 3;
		AGE.MATURE:
			amount = 2;
		AGE.OLD:
			pass
	resources[RES.P] = resources[RES.P] + amount;
	if resources[RES.P] > 50:
		resources[RES.P] = 50;

func deplete_resources():
	var amount = 0;
	match cur_age:
		AGE.INFANT:
			pass
		AGE.CHILD:
			amount = 0.5;
		AGE.TEEN:
			amount = 0.5;
		AGE.YA:
			amount = 0.3;
		AGE.MATURE:
			amount = 0.2;
		AGE.OLD:
			pass
	resources[RES.EN] = resources[RES.EN] - amount;
	resources[RES.ENT] = resources[RES.ENT] - amount;
	if resources[RES.EN] <= 0:
		resources[RES.EN] = 0;
		emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1;
		emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1;
	if resources[RES.ENT] <= 0:
		resources[RES.ENT] = 0;
		emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1;
		emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1;
	
