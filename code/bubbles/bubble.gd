extends CharacterBody2D
class_name Bubble

enum EMOTION {JOY, ANGER, SADNESS, FEAR, DISGUST}

enum AGE {INFANT, CHILD, TEEN, YA, MATURE, OLD}

# Aura node
var aura_active = 1;
var aura_inactive = 2;
var aura_max_size = Vector2(3,3);
var aura_min_size = Vector2(1,1);

# Determines how much one can change emotions of others
var influence_strength = 1;

var aura_tween;

# Add colors and color mixing (use a white bubble and then do some color modulation based on weights)
var red_emotion =   [1.0, 1.0, 0.0, 1.0, 0.0];
var green_emotion = [1.0, 0.0, 0.0, 0.0, 1.0];
var blue_emotion =  [0.0, 0.0, 1.0, 1.0, 0.0];

# Moving
var speed = 200

# Emotions for each bubble
var emotions = [0.0, 0.0, 0.0, 0.0, 0.0];
var spreading_emotion;

# Age
var cur_age = AGE.INFANT;

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

func _process(delta):
	var sum_all = 0.0;
	# Color weighting and mixing (work in progress)
	var red = 0.0;
	var blue = 0.0;
	var green = 0.0;
	for i in range(0,5):
		sum_all = sum_all + emotions[i];
		red = red + red_emotion[i]*emotions[i];
		green = green + green_emotion[i]*emotions[i];
		blue = blue + blue_emotion[i]*emotions[i];
	red = red/sum_all;
	green = green/sum_all;
	blue = blue/sum_all;
	
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
	$Influence/Shape.modulate = Color(red_emotion[spreading_emotion],green_emotion[spreading_emotion],blue_emotion[spreading_emotion]);
	$Influence/Shape.modulate.a = 0.25


func _physics_process(_delta):
	# Check for influencing emotions
	var overlapping_areas = $Influence.get_overlapping_areas();
	for area in overlapping_areas:
		if area != $GetInfluenced:
			area.get_parent().influence_emotion(spreading_emotion,influence_strength);
			

func start_tween():
	aura_tween = create_tween().set_loops();
	aura_tween.tween_property($Influence,"scale",aura_min_size,aura_inactive);
	aura_tween.tween_property($Influence,"scale",aura_max_size,0.5*aura_active);
	aura_tween.tween_property($Influence,"scale",aura_min_size,0.5*aura_active);
	aura_tween.loop_finished.connect(tween_loop_finished);
	
func tween_loop_finished(loop_idx):
	spreading_emotion = get_random_emotion();

func influence_emotion(emotion,value):
	emotions[emotion] = emotions[emotion] + value;


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
			scale = $Infant.get_rect().size.x/$Sprite.get_rect().size.x*Vector2(1,1);
		AGE.CHILD: 
			$Infant.modulate.a = 1.0;
			$Infant.modulate = colors[0];
			$Child.modulate.a = 1.0;
			$Teen.modulate.a = 0.0;
			$YA.modulate.a = 0.0;
			$Mature.modulate.a = 0.0;
			$Old.modulate.a = 0.0;
			scale = $Child.get_rect().size.x/$Sprite.get_rect().size.x*Vector2(1,1);
		AGE.TEEN: 
			$Infant.modulate.a = 1.0;
			$Infant.modulate = colors[0];
			$Child.modulate.a = 1.0;
			$Child.modulate = colors[1];
			$Teen.modulate.a = 1.0;
			$YA.modulate.a = 0.0;
			$Mature.modulate.a = 0.0;
			$Old.modulate.a = 0.0;
			scale = $Teen.get_rect().size.x/$Sprite.get_rect().size.x*Vector2(1,1);
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
			scale = $YA.get_rect().size.x/$Sprite.get_rect().size.x*Vector2(1,1);
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
			scale = $Mature.get_rect().size.x/$Sprite.get_rect().size.x*Vector2(1,1);
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
			scale = $Old.get_rect().size.x/$Sprite.get_rect().size.x*Vector2(1,1);	
	$Sprite.scale = scale;
	$GetInfluenced.scale = scale;
	$CollisionShape2D.scale = scale;
	aura_min_size = scale;
	aura_max_size = 3*scale;
	
	
func age():
	pass

func die():
	pass

func get_random_emotion():
	var sum_all = 0;
	for i in range (0,5):
		sum_all = sum_all + emotions[i];
	var random = randf_range(0, sum_all);
	var cur_limit = emotions[0];
	for i in range (0,5):
		if random <= cur_limit:
			return i;
		if i < 4:
			cur_limit = cur_limit + emotions[i+1]
