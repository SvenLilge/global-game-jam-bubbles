extends Bubble


var deadzone_threshold_trans = 0.3;
var deadzone_threshold_rot = 0.6;
var move_dir = Vector2(0,0);

var energy = 0;
var entertainment = 0;
var education_money = 0;
var personal = 0;

@onready var influence = $Influence;

func _ready():
	speed = 400;
	emotions[Bubble.EMOTION.JOY] = 100.0;
	influence_strength = 0;
	super._ready();

func _physics_process(delta):
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
	#health = health - overlapping_mobs.size()*damage_rate*delta;
	#$HealthBar.value = health;
	#if health <= 0.0:
	#	health_depleted.emit();
		
	# Update Player position
	move_and_slide();
