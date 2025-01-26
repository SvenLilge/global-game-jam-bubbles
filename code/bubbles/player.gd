extends Bubble

enum RES {EN, ENT, ED, MON, P}

var deadzone_threshold_trans = 0.3;
var deadzone_threshold_rot = 0.6;
var move_dir = Vector2(0,0);
var level_active = false;

# [energy, fun, educatation, mone, personal]
var resources = [0,0,0,0,0]


@onready var influence = $Influence;
@onready var hud = get_parent().hud

func _ready():
	influence_strength = 0;
	super._ready();
	var colors = [];
	set_age_state(AGE.INFANT,colors);
	
	
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
	
	hud.set_energy(resources[RES.EN])

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
	
	hud.set_entertainment(resources[RES.ENT])
		
func pickup_education():
	var amount = 0;
	match cur_age:
		AGE.INFANT:
			pass
		AGE.CHILD:
			amount = 2;
		AGE.TEEN:
			amount = 1;
		AGE.YA:
			pass
		AGE.MATURE:
			pass
		AGE.OLD:
			pass
	resources[RES.ED] = resources[RES.ED] + amount;
	hud.set_education(resources[RES.ED])
		
func pickup_money():
	var amount = 0;
	match cur_age:
		AGE.INFANT:
			pass
		AGE.CHILD:
			pass
		AGE.TEEN:
			pass
		AGE.YA:
			var tmp = (int(2*resources[RES.ED] + resources[RES.MON]))%100;
			amount = 1 + tmp;
			if amount > 5:
				amount = 5;
		AGE.MATURE:
			var tmp = (int(resources[RES.ED] + 1*resources[RES.MON]))%300;
			amount = 2 + 2*tmp;
			if amount > 20:
				amount = 20;
		AGE.OLD:
			pass
	resources[RES.MON] = resources[RES.MON] + amount;
	hud.set_money(resources[RES.MON])
		
func pickup_personal():
	var amount = 0;
	match cur_age:
		AGE.INFANT:
			pass
		AGE.CHILD:
			amount = 2;
		AGE.TEEN:
			amount = 1;
		AGE.YA:
			var tmp = (int(resources[RES.P]))%100;
			amount = 1 + tmp;
			if amount > 3:
				amount = 3;
		AGE.MATURE:
			var tmp = (int(resources[RES.P] + 2*resources[RES.ED] + 0.2*resources[RES.MON]))%400;
			amount = 2 + 2*tmp;
			if amount > 10:
				amount = 10;
		AGE.OLD:
			pass
	resources[RES.P] = resources[RES.P] + amount;
	hud.set_personal(resources[RES.P])

func deplete_resources():
	if level_active:
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
			match cur_age:
				AGE.INFANT:
					pass
				AGE.CHILD:
					emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1.0/3.0;
					emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1.0/3.0;
				AGE.TEEN:
					emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1;
					emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1;
				AGE.YA:
					emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1.0/2.0;
					emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1.0/2.0;
				AGE.MATURE:
					emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1.0/3.0;
					emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1.0/3.0;
				AGE.OLD:
					pass
		if resources[RES.ENT] <= 0:
			resources[RES.ENT] = 0;
			match cur_age:
				AGE.INFANT:
					pass
				AGE.CHILD:
					emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1.0/3.0;
					emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1.0/3.0;
				AGE.TEEN:
					emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1;
					emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1;
				AGE.YA:
					emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1.0/2.0;
					emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1.0/2.0;
				AGE.MATURE:
					emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1.0/3.0;
					emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1.0/3.0;
				AGE.OLD:
					pass
		
		hud.set_energy(resources[RES.EN])
		hud.set_entertainment(resources[RES.ENT])
	
