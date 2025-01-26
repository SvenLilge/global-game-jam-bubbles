extends Node2D
class_name Pickup


var resource_given = false

@onready var player = get_parent().get_parent().player;

enum TYPE {ENERGY, ENTERTAINMENT, EDUCATION, MONEY, PERSONAL}

var cur_type = TYPE.ENERGY;

func _ready() -> void:
	$DurationTimer.wait_time = 10.0;
	$DurationTimer.one_shot = true;
	$DurationTimer.start();
	$DurationTimer.timeout.connect(vanish);
	vobble()


func _process(delta: float) -> void:
	if($Area.overlaps_body(player)):
		if not resource_given:
			provide_resource();
		vanish();


func vobble():
	await get_tree().create_timer(0.4).timeout
	var pos_from = $Sprite.position
	var pos_to = pos_from + Vector2(0, -20)
	var tween_move = get_tree().create_tween()
	tween_move.tween_property($Sprite, "position", pos_to, 0.6).set_trans(Tween.TRANS_SINE)
	tween_move.tween_property($Sprite, "position", pos_from, 0.6).set_trans(Tween.TRANS_SINE)
	tween_move.tween_callback(vobble)


func set_type(type):
	cur_type = type;
	if cur_type == TYPE.ENERGY:
		$Sprite.frame = 0
	if cur_type == TYPE.ENTERTAINMENT:
		$Sprite.frame = 1
	if cur_type == TYPE.EDUCATION:
		$Sprite.frame = 2
	if cur_type == TYPE.MONEY:
		$Sprite.frame = 3
	if cur_type == TYPE.PERSONAL:
		$Sprite.frame = 4
	

func vanish():
	queue_free();
	
func provide_resource():
	if cur_type == TYPE.ENERGY:
		player.pickup_energy();
	if cur_type == TYPE.ENTERTAINMENT:
		player.pickup_entertainment();
	if cur_type == TYPE.EDUCATION:
		player.pickup_education();
	if cur_type == TYPE.MONEY:
		player.pickup_money();
	if cur_type == TYPE.PERSONAL:
		player.pickup_personal();
	pass
