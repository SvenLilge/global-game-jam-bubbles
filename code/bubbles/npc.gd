extends Bubble

# Moving
var move_dir = Vector2(0,0);

func _ready():
	emotions[Bubble.EMOTION.ANGER] = 100;
	super._ready();

func _physics_process(_delta):
	super._physics_process(_delta)
	# Detect Player pos and move towards it
	move_dir = (get_parent().player.global_position - global_position).normalized();
	velocity = move_dir * speed

		
	# Update NPC position
	move_and_slide();
