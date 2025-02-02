extends CharacterBody2D
class_name Bubble
@onready var influence = $Influence;
@onready var sprite = $Sprite;

enum EMOTION {JOY, ANGER, SADNESS}

enum BUB_CLASS {YOU, RELATIVE, DUDE, BOSS, FRIEND, DOG, BABY, RANDOM}

enum AGE {INFANT, CHILD, TEEN, YA, MATURE, OLD}


# Aura node
var aura_active = 1.5;
var aura_inactive = 2.7;
var aura_max_size = Vector2(5,5);
var aura_min_size = Vector2(1,1);

# Determines how much one can change emotions of others
var influence_strength = 1;
var influence_base = 0.01;

var aura_tween;

# Add colors and color mixing (use a white bubble and then do some color modulation based on weights)
var red_emotion =   [0.0, 1.0, 0.0];
var green_emotion = [1.0, 0.0, 0.0];
var blue_emotion =  [0.0, 0.0, 1.0];

# Moving
var speed = 300
var base_speed = 300;

# Emotions for each bubble
var emotions = [0.0, 0.0, 0.0];
var spreading_emotion;

# class of the bubble
@export var bubble_class: BUB_CLASS

# Age and Color
var cur_age = AGE.INFANT;
var cur_color;
var can_talk = true
var last_stage = false

@onready var text_bubble = load("res://code/text_bubbles/text_bubble.tscn")

@onready var tween_timer = $TweenDelayTimer;

func _ready() -> void:
	$TweenDelayTimer.one_shot = true;
	$TweenDelayTimer.wait_time = randf_range(0,2);
	$TweenDelayTimer.timeout.connect(start_tween);
	$TweenDelayTimer.start();
	
	$ChatTimer.one_shot = true;
	$ChatTimer.wait_time = aura_active;
	
	spreading_emotion = get_random_emotion();
	
	$Sprite.modulate.a = 1;

func _process(delta):
	var sum_all = 0.0;
	# Color weighting and mixing (work in progress)
	var red = 0.0;
	var blue = 0.0;
	var green = 0.0;
	for i in range(0,3):
		sum_all = sum_all + emotions[i];
		red = red + red_emotion[i]*emotions[i];
		green = green + green_emotion[i]*emotions[i];
		blue = blue + blue_emotion[i]*emotions[i];
	red = red/sum_all;
	green = green/sum_all;
	blue = blue/sum_all;
	
	# middle collor hets **1.5, max color gets **0.75, min color gets ** 2.25
	var colors_list = [red ** 1.5, green ** 1.5, blue ** 1.5]
	var max_color = colors_list.find(colors_list.max())
	var min_color = colors_list.find(colors_list.min())
	colors_list[max_color] = colors_list[max_color] ** 0.5
	colors_list[min_color] = colors_list[min_color] ** 1.5
	
	cur_color = Color(colors_list[0], colors_list[1], colors_list[2]);
	
	if(sum_all == 0.0):
		red = 1.0;
		blue = 1.0;
		green = 1.0;
	match cur_age:
		AGE.INFANT:
			$Infant.modulate = Color(red,green,blue);
		AGE.CHILD:
			$Child.modulate = Color(red,green,blue);
		AGE.TEEN:
			$Teen.modulate = Color(red,green,blue);
		AGE.YA:
			$YA.modulate = Color(red,green,blue);
		AGE.MATURE:
			$Mature.modulate = Color(red,green,blue);
		AGE.OLD:
			$Old.modulate = Color(red,green,blue);
	$BG.modulate = Color(red,green,blue);
	$Influence/Shape.modulate = Color(red_emotion[spreading_emotion],green_emotion[spreading_emotion],blue_emotion[spreading_emotion]);
	$Influence/Shape.modulate.a = 0.25


func _physics_process(_delta):
	# Check for influencing emotions
	var overlapping_areas = $Influence.get_overlapping_areas();
	for area in overlapping_areas:
		if area != $GetInfluenced:
			area.get_parent().influence_emotion(spreading_emotion,influence_strength);
			

func start_tween():
	if aura_tween:
		aura_tween.kill()
	var wait_time = (randi() % 61)/100.0 + aura_inactive
	aura_tween = create_tween().set_loops();
	aura_tween.tween_property($Influence/Shape,"modulate:a",0,0);
	aura_tween.tween_property($Influence,"scale",aura_min_size,0);
	aura_tween.tween_property($Influence,"scale",aura_min_size,wait_time);
	if can_talk:
		aura_tween.tween_callback(call_say_bubble)
	aura_tween.tween_property($Influence/Shape,"modulate:a",1,0);
	aura_tween.tween_property($Influence,"scale",aura_max_size,0.7*aura_active).set_trans(Tween.TRANS_QUAD);
	aura_tween.tween_property($Influence/Shape,"modulate:a",0,0.3*aura_active)
	aura_tween.tween_callback($Influence.set_scale.bind(aura_min_size));
	aura_tween.loop_finished.connect(tween_loop_finished);
	
func tween_loop_finished(loop_idx):
	spreading_emotion = get_random_emotion();

func influence_emotion(emotion, value):
	if last_stage:
		return
		
	if $ChatTimer.is_stopped():
		$ChatTimer.start();
		call_response_bubble(emotion)
	emotions[emotion] = emotions[emotion] + value*2;
	


func call_say_bubble():
	if not can_talk:
		return
		
	if cur_age != AGE.INFANT and bubble_class != BUB_CLASS.RANDOM:
		var say_bubble = text_bubble.instantiate()
		add_child(say_bubble)
		#say_bubble.position = position #usefull if attach to parent
		say_bubble.say_emotion(bubble_class, spreading_emotion)


func call_response_bubble(emotion):
	#if not can_talk:
		#return
		
	var resp_bubble = text_bubble.instantiate()
	add_child(resp_bubble)
	#resp_bubble.position = position #usefull if attach to parent
	if bubble_class == BUB_CLASS.RANDOM:
		resp_bubble.respond(bubble_class, emotion)
	elif bubble_class == BUB_CLASS.BABY:
		resp_bubble.respond(bubble_class, emotion)
	elif bubble_class == BUB_CLASS.DOG:
		resp_bubble.respond(bubble_class, emotion)
	else:
		var max_emotion = emotions.max()
		var dominant_emotion = emotions.find(max_emotion)
		resp_bubble.respond(dominant_emotion, emotion)


func set_age_state(age, colors):
	cur_age = age;
	var new_scale;
	match age:
		AGE.INFANT: 
			$Infant.modulate.a = 1.0;
			$Child.modulate.a = 0.0;
			$Teen.modulate.a = 0.0;
			$YA.modulate.a = 0.0;
			$Mature.modulate.a = 0.0;
			$Old.modulate.a = 0.0;
			new_scale = $Infant.scale.x/$Mature.scale.x*Vector2(1,1);
			speed=0.6*base_speed;
			influence_strength = 0*influence_base;
		AGE.CHILD: 
			$Infant.modulate.a = 1.0;
			$Infant.modulate = colors[0];
			$Child.modulate.a = 1.0;
			$Teen.modulate.a = 0.0;
			$YA.modulate.a = 0.0;
			$Mature.modulate.a = 0.0;
			$Old.modulate.a = 0.0;
			new_scale = $Child.scale.x/$Mature.scale.x*Vector2(1,1);
			speed=0.75*base_speed;
			influence_strength = 0.3*influence_base;
		AGE.TEEN: 
			$Infant.modulate.a = 1.0;
			$Infant.modulate = colors[0];
			$Child.modulate.a = 1.0;
			$Child.modulate = colors[1];
			$Teen.modulate.a = 1.0;
			$YA.modulate.a = 0.0;
			$Mature.modulate.a = 0.0;
			$Old.modulate.a = 0.0;
			new_scale = $Teen.scale.x/$Mature.scale.x*Vector2(1,1);
			speed=1.25*base_speed;
			influence_strength = 0.7*influence_base;
		AGE.YA: 
			$Infant.modulate.a = 1.0;
			$Infant.modulate = colors[0];
			$Child.modulate.a = 1.0;
			$Child.modulate = colors[1];
			$Teen.modulate.a = 1.0;
			$Teen.modulate = colors[2];
			$YA.modulate.a = 1.0;
			$Mature.modulate.a = 0.0;
			$Old.modulate.a = 0.0;
			new_scale = $YA.scale.x/$Mature.scale.x*Vector2(1,1);
			speed=1*base_speed;1
			influence_strength = 1*influence_base;
		AGE.MATURE: 
			$Infant.modulate.a = 1.0;
			$Infant.modulate = colors[0];
			$Child.modulate.a = 1.0;
			$Child.modulate = colors[1];
			$Teen.modulate.a = 1.0;
			$Teen.modulate = colors[2];
			$YA.modulate.a = 1.0;
			$YA.modulate = colors[3];
			$Mature.modulate.a = 1.0;
			$Old.modulate.a = 0.0;
			new_scale = $Mature.scale.x/$Mature.scale.x*Vector2(1,1);
			speed=0.75*base_speed;
			influence_strength = 1.5*influence_base;
		AGE.OLD: 
			$Infant.modulate.a = 1.0;
			$Infant.modulate = colors[0];
			$Child.modulate.a = 1.0;
			$Child.modulate = colors[1];
			$Teen.modulate.a = 1.0;
			$Teen.modulate = colors[2];
			$YA.modulate.a = 1.0;
			$YA.modulate = colors[3];
			$Mature.modulate.a = 1.0;
			$Mature.modulate = colors[4];
			$Old.modulate.a = 1.0;
			new_scale = $Old.scale.x/$Mature.scale.x*Vector2(1,1);
			speed=0.5*base_speed;
			influence_strength = 0.5*influence_base;
	$Sprite.scale = new_scale*$Mature.scale.x*$Mature.get_rect().size.x/$Sprite.get_rect().size.x;
	$GetInfluenced.scale = new_scale;
	$CollisionShape2D.scale = new_scale;
	$BG.scale = new_scale;
	aura_min_size = new_scale;
	aura_max_size = 3*new_scale;
	if (cur_age == AGE.INFANT) or (bubble_class == BUB_CLASS.RANDOM):
		aura_max_size = aura_min_size * 0.5;
	start_tween();
	
	
func age():
	if cur_age < AGE.OLD:
		var colors = [];
		if cur_age >= AGE.INFANT:
			colors.append($Infant.modulate);
		if cur_age >= AGE.CHILD:
			colors.append($Child.modulate);
		if cur_age >= AGE.TEEN:
			colors.append($Teen.modulate);
		if cur_age >= AGE.YA:
			colors.append($YA.modulate);
		if cur_age >= AGE.MATURE:
			colors.append($Mature.modulate);
		colors.append(cur_color);
		set_age_state(cur_age+1,colors);
	
	var sum_all = 0.1;
	for i in range (0,3):
		sum_all = sum_all + emotions[i];
	for i in range (0,3):
		emotions[i] = emotions[i]/sum_all*5;
		

func die():
	pass

func get_random_emotion():
	var sum_all = 0;
	for i in range (0,3):
		sum_all = sum_all + emotions[i];
	var random = randf_range(0, sum_all);
	var cur_limit = emotions[0];
	for i in range (0,3):
		if random <= cur_limit:
			return i;
		if i < 2:
			cur_limit = cur_limit + emotions[i+1]
	return 0;
