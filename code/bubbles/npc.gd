extends Bubble

# Moving
var move_dir = Vector2(0,0);
var random_move_dir = Vector2(0,0);

var detect_range = 300;

var min_pos = null;
var max_pos = null;

func _ready():
	super._ready();
	pick_random_move();
	$RandomMoveTimer.one_shot = false;
	$RandomMoveTimer.wait_time = 1;
	$RandomMoveTimer.timeout.connect(pick_random_move);
	$RandomMoveTimer.start();

func _physics_process(_delta):
	super._physics_process(_delta)
	
	# Check dominant emotion and determine motion pattern
	
	# Always move randomly with 0.25 speed
	move_dir = random_move_dir;
	velocity = move_dir * 0.25 * speed
	
	# If angry instead chase player if he's close enough
	if(emotions[EMOTION.ANGER] > emotions[EMOTION.JOY] and emotions[EMOTION.ANGER] > emotions[EMOTION.SADNESS]):
		if (get_parent().player.global_position - global_position).length() <= detect_range:
			move_dir = (get_parent().player.global_position - global_position).normalized();
			velocity = move_dir * 0.5 * speed
	
	# If happy instead chase player if he's close enough and is also happy
	if(emotions[EMOTION.JOY] > emotions[EMOTION.ANGER] and emotions[EMOTION.JOY] > emotions[EMOTION.SADNESS]):
		if (get_parent().player.global_position - global_position).length() <= detect_range:
			move_dir = (get_parent().player.global_position - global_position).normalized();
			if(get_parent().player.emotions[EMOTION.JOY] > get_parent().player.emotions[EMOTION.ANGER] and get_parent().player.emotions[EMOTION.JOY] > get_parent().player.emotions[EMOTION.SADNESS]):
				velocity = move_dir * 0.25 * speed
			else:
				velocity = -1*move_dir * 0.25 * speed
	# Update NPC position
	move_and_slide();
	
	# Check if we went outside area
	if min_pos != null:
		if position.x < min_pos.x:
			position.x = min_pos.x;
		if position.y < min_pos.y:
			position.y = min_pos.y;
	if max_pos != null:
		if position.x > max_pos.x:
			position.x = max_pos.x;
		if position.y > max_pos.y:
			position.y = max_pos.y;

func pick_random_move():
	var x = randf_range(-1,1);
	var y = randf_range(-1,1);
	
	random_move_dir = Vector2(x,y).normalized();
