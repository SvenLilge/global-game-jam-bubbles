extends Node2D

var resource_given = false

@onready var player = get_parent().get_parent().player;

enum TYPE {ENERGY, ENTERTAINMENT, EDUCATION, PERSONAL}

var cur_type = TYPE.ENERGY;

func _ready() -> void:
	$DurationTimer.wait_time = 10.0;
	$DurationTimer.one_shot = true;
	$DurationTimer.start();
	$DurationTimer.timeout.connect(vanish);

func _process(delta: float) -> void:
	if($Area.overlaps_body(player)):
		if not resource_given:
			provide_resource();
		vanish();

func set_type(type):
	cur_type = type;
	if cur_type == TYPE.ENERGY:
		$Sprite.modulate = Color(1,1,0);
	if cur_type == TYPE.ENTERTAINMENT:
		$Sprite.modulate = Color(1,0,0);
	if cur_type == TYPE.EDUCATION:
		$Sprite.modulate = Color(0,1,0);
	if cur_type == TYPE.PERSONAL:
		$Sprite.modulate = Color(0,0,1);
	

func vanish():
	queue_free();
	
func provide_resource():
	if cur_type == TYPE.ENERGY:
		player.pickup_energy();
	if cur_type == TYPE.ENTERTAINMENT:
		player.pickup_entertainment();
	if cur_type == TYPE.EDUCATION:
		player.pickup_education_money();
	if cur_type == TYPE.PERSONAL:
		player.pickup_personal();
	pass
