extends CharacterBody2D
class_name Bubble

enum EMOTION {JOY, ANGER, SADNESS, FEAR, DISGUST}

# Aura node
var aura_active = 1;
var aura_inactive = 2;
var aura_max_size = Vector2(3,3);
var aura_min_size = Vector2(1,1);

# Determines how much one can change emotions of others
var influence_strength = 1;


# Add colors and color mixing (use a white bubble and then do some color modulation based on weights)
var red_emotion =   [1.0, 1.0, 0.0, 1.0, 0.0];
var green_emotion = [1.0, 0.0, 0.0, 0.0, 1.0];
var blue_emotion =  [0.0, 0.0, 1.0, 1.0, 0.0];

# Moving
var speed = 200

# Emotions for each bubble
var emotions = [0.0, 0.0, 0.0, 0.0, 0.0];

func _ready() -> void:
	var aura_tween = create_tween().set_loops();
	aura_tween.tween_property($Influence,"scale",aura_min_size,aura_inactive);
	aura_tween.tween_property($Influence,"scale",aura_max_size,0.5*aura_active);
	aura_tween.tween_property($Influence,"scale",aura_min_size,0.5*aura_active);
	

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
	print(Color(red,green,blue))
	$Sprite.modulate = Color(red,green,blue);
	$Influence/Shape.modulate = Color(red,green,blue);
	$Influence/Shape.modulate.a = 0.25


func _physics_process(_delta):
	# Check for influencing emotions
	var overlapping_areas = $Influence.get_overlapping_areas();
	for area in overlapping_areas:
		if area != $GetInfluenced:
			area.get_parent().influence_emotion(get_random_emotion(),influence_strength);
			

func influence_emotion(emotion,value):
	emotions[emotion] = emotions[emotion] + value;
	
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
