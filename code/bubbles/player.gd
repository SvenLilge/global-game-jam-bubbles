extends Bubble

enum RES {EN, ENT, ED, MON, P}

var deadzone_threshold_trans = 0.3;
var deadzone_threshold_rot = 0.6;
var move_dir = Vector2(0,0);
var level_active = false;

# [energy, fun, educatation, mone, personal]
var resources = [5,5,0,0,0]


@onready var influence = $Influence;
var hud


@onready var baby_song = $Music/InfTrack
@onready var child_song = $Music/ChildTrack
@onready var teen_song = $Music/TeenTrack
@onready var ya_song = $Music/YATrack
@onready var mat_song = $Music/MatureTrack
@onready var old_song = $Music/OldTrack

@onready var joy_song = $Music/JoyPlayer
@onready var anger_song = $Music/AngryTrack
@onready var sad_song = $Music/SadnessPlayer
@onready var emo_timer = $EmotionChecker

var left_up_loc_song
var left_down_loc_song
var right_up_loc_song
var right_down_loc_song

var song_emotion = 0


func _ready():
	influence_strength = 0;
	super._ready();
	var colors = [];
	set_age_state(AGE.INFANT,colors);
	emo_timer.timeout.connect(set_emotion_song)


func set_hud():
	hud = get_parent().hud
	
	$ResourceDepletionTimer.one_shot = false;
	$ResourceDepletionTimer.wait_time = 1;
	$ResourceDepletionTimer.timeout.connect(deplete_resources);
	$ResourceDepletionTimer.start();


func _physics_process(delta):
	
	if level_active:
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
			if(Input.is_key_pressed(KEY_W)) or (Input.is_key_pressed(KEY_UP)):
				up = 1;
			if(Input.is_key_pressed(KEY_S)) or (Input.is_key_pressed(KEY_DOWN)):
				up = -1;
			if(Input.is_key_pressed(KEY_A)) or (Input.is_key_pressed(KEY_LEFT)):
				left = 1;
			if(Input.is_key_pressed(KEY_D)) or (Input.is_key_pressed(KEY_RIGHT)):
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
		
		update_location_music(position)


func update_location_music(pos:Vector2):
	if left_up_loc_song == null:
		return
	
	var left_up_dist = pos.distance_to(Vector2(400,190))
	var left_down_dist = pos.distance_to(Vector2(400,890))
	var right_up_dist = pos.distance_to(Vector2(1520,190))
	var right_down_dist = pos.distance_to(Vector2(1520,890))


func new_stage_music(stage):
	for track:AudioStreamPlayer in $Music.get_children():
		track.stop()
	for track:AudioStreamPlayer in $LocMusic.get_children():
		track.stop()
	
	match stage:
		0:
			baby_song.play()
			baby_song.volume_db = -100
		1:
			child_song.play()
			child_song.volume_db = -100
			left_up_loc_song = $LocMusic/Home
			left_down_loc_song = $LocMusic/Mall
			right_up_loc_song = $LocMusic/School
			right_down_loc_song = $LocMusic/Friend
		2:
			teen_song.play()
			teen_song.volume_db = -100
			left_up_loc_song = $LocMusic/Home
			left_down_loc_song = $LocMusic/Mall
			right_up_loc_song = $LocMusic/School
			right_down_loc_song = $LocMusic/Friend
		3:
			ya_song.play()
			ya_song.volume_db = -100
			left_up_loc_song = $LocMusic/Home
			left_down_loc_song = $LocMusic/Mall
			right_up_loc_song = $LocMusic/School
			right_down_loc_song = $LocMusic/Friend
		4:
			mat_song.play()
			mat_song.volume_db = -100
			left_up_loc_song = $LocMusic/Home
			left_down_loc_song = $LocMusic/Mall
			right_up_loc_song = $LocMusic/School
			right_down_loc_song = $LocMusic/Friend
		5:
			old_song.play()
	
	if stage in [1,2,3,4]:
		left_up_loc_song.play()
		left_down_loc_song.play()
		right_up_loc_song.play()
		right_down_loc_song.play()
		left_up_loc_song.volume_db = -100
		left_down_loc_song.volume_db = -100
		right_up_loc_song.volume_db = -100
		right_down_loc_song.volume_db = -100
	
	if stage != 5:
		anger_song.play()
		joy_song.play()
		sad_song.play()
		
		anger_song.volume_db = -100
		joy_song.volume_db = -100
		sad_song.volume_db = -100
		
		emo_timer.start(4.0)
		set_emotion_song()
	

func set_emotion_song():
	var max_emotion = emotions.max()
	var dominant_emotion = emotions.find(max_emotion)
	print(emotions)
	
	if dominant_emotion != song_emotion:
		var music_levels = [-100, -100, -100]
		music_levels[dominant_emotion] = 0
		
		print("levels", music_levels)
		
		var tween_joy = get_tree().create_tween()
		tween_joy.tween_property(joy_song, "volume_db", music_levels[0], 1).set_trans(Tween.TRANS_SINE)
		
		var tween_anger = get_tree().create_tween()
		tween_anger.tween_property(anger_song, "volume_db", music_levels[1], 1).set_trans(Tween.TRANS_SINE)
		
		var tween_sad = get_tree().create_tween()
		tween_sad.tween_property(sad_song, "volume_db", music_levels[2], 1).set_trans(Tween.TRANS_SINE)



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
	if resources[RES.EN] > 15:
		resources[RES.EN] = 15;
	
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
	if resources[RES.ENT] > 15:
		resources[RES.ENT] = 15;
	
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
					emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1.0/3.0;
				AGE.TEEN:
					emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1;
				AGE.YA:
					emotions[Bubble.EMOTION.SADNESS] = emotions[Bubble.EMOTION.SADNESS] + 1.0/2.0;
				AGE.MATURE:
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
				AGE.TEEN:
					emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1;
				AGE.YA:
					emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1.0/2.0;
				AGE.MATURE:
					emotions[Bubble.EMOTION.ANGER] = emotions[Bubble.EMOTION.ANGER] + 1.0/3.0;
				AGE.OLD:
					pass
		
		hud.set_energy(resources[RES.EN])
		hud.set_entertainment(resources[RES.ENT])
	
