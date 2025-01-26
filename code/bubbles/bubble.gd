extends CharacterBody2D
class_name Bubble

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

var aura_tween;

# Add colors and color mixing (use a white bubble and then do some color modulation based on weights)
var red_emotion =   [0.0, 1.0, 0.0];
var green_emotion = [1.0, 0.0, 0.0];
var blue_emotion =  [0.0, 0.0, 1.0];

# Moving
var speed = 200

# Emotions for each bubble
var emotions = [0.0, 0.0, 0.0];
var spreading_emotion;

# class of the bubble
@export var bubble_class: BUB_CLASS

# Age and Color
var cur_age = AGE.INFANT;
var cur_color;

@onready var text_bubble = load("res://code/text_bubbles/text_bubble.tscn")

func _ready() -> void:
	$TweenDelayTimer.one_shot = true;
	$TweenDelayTimer.wait_time = randf_range(0,2);
	$TweenDelayTimer.timeout.connect(start_tween);
	$TweenDelayTimer.start();
	
	spreading_emotion = get_random_emotion();
	
	var colors = [];
	colors.append(Color(1,0,0));
	colors.append(Color(0,1,0));
	colors.append(Color(0,0,1));
	set_age_state(AGE.YA,colors);
	
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
	
	cur_color = Color(red,green,blue);
	
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
	var wait_time = (randi() % 61)/100.0 + aura_inactive
	
	aura_tween = create_tween().set_loops();
	aura_tween.tween_property($Influence/Shape,"modulate:a",0,0);
	aura_tween.tween_property($Influence,"scale",aura_min_size,wait_time);
	aura_tween.tween_callback(call_say_bubble)
	aura_tween.tween_property($Influence/Shape,"modulate:a",1,0);
	aura_tween.tween_property($Influence,"scale",aura_max_size,0.7*aura_active).set_trans(Tween.TRANS_QUAD);
	aura_tween.tween_property($Influence/Shape,"modulate:a",0,0.3*aura_active)
	aura_tween.tween_callback($Influence.set_scale.bind(aura_min_size));
	aura_tween.loop_finished.connect(tween_loop_finished);
	
func tween_loop_finished(loop_idx):
	spreading_emotion = get_random_emotion();

func influence_emotion(emotion, value):
	call_response_bubble(emotion)
	emotions[emotion] = emotions[emotion] + value;


func call_say_bubble():
	var say_bubble = text_bubble.instantiate()
	add_child(say_bubble)
	#say_bubble.position = position #usefull if attach to parent
	say_bubble.say_emotion(bubble_class, spreading_emotion)


func call_response_bubble(emotion):
	var resp_bubble = text_bubble.instantiate()
	add_child(resp_bubble)
	#resp_bubble.position = position #usefull if attach to parent
	if bubble_class == BUB_CLASS.RANDOM:
		resp_bubble.respond(bubble_class)
	elif bubble_class == BUB_CLASS.BABY:
		resp_bubble.respond(bubble_class)
	else:
		var max_emotion = emotions.max()
		var dominant_emotion = emotions.find(max_emotion)
		resp_bubble.respond(dominant_emotion, emotion)


func set_age_state(age, colors):
	cur_age = age;
	var scale;
	match age:
		AGE.INFANT: 
			$Infant.modulate.a = 1.0;
			$Child.modulate.a = 0.0;
			$Teen.modulate.a = 0.0;
			$YA.modulate.a = 0.0;
			$Mature.modulate.a = 0.0;
			$Old.modulate.a = 0.0;
			scale = $Infant.get_rect().size.x/$Mature.get_rect().size.x*Vector2(1,1);
		AGE.CHILD: 
			$Infant.modulate.a = 1.0;
			$Infant.modulate = colors[0];
			$Child.modulate.a = 1.0;
			$Teen.modulate.a = 0.0;
			$YA.modulate.a = 0.0;
			$Mature.modulate.a = 0.0;
			$Old.modulate.a = 0.0;
			scale = $Child.get_rect().size.x/$Mature.get_rect().size.x*Vector2(1,1);
		AGE.TEEN: 
			$Infant.modulate.a = 1.0;
			$Infant.modulate = colors[0];
			$Child.modulate.a = 1.0;
			$Child.modulate = colors[1];
			$Teen.modulate.a = 1.0;
			$YA.modulate.a = 0.0;
			$Mature.modulate.a = 0.0;
			$Old.modulate.a = 0.0;
			scale = $Teen.get_rect().size.x/$Mature.get_rect().size.x*Vector2(1,1);
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
			scale = $YA.get_rect().size.x/$Mature.get_rect().size.x*Vector2(1,1);
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
			scale = $Mature.get_rect().size.x/$Mature.get_rect().size.x*Vector2(1,1);
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
			scale = $Old.get_rect().size.x/$Mature.get_rect().size.x*Vector2(1,1);	
	$Sprite.scale = scale*$Mature.get_rect().size.x/$Sprite.get_rect().size.x;
	$GetInfluenced.scale = scale;
	$CollisionShape2D.scale = scale;
	$BG.scale = scale;
	aura_min_size = scale;
	aura_max_size = 3*scale;
	
	
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
		if i < 4:
			cur_limit = cur_limit + emotions[i+1]
