extends "res://code/game_states/game_state.gd" 

@onready var player = get_parent().player;

var camera_tween = null;

var camera_pan_speed = 0.5;

func _ready():
	super._ready();
	player.show();
	return;

func _physics_process(delta: float):
	
	if camera_tween == null:
		if($Area1.overlaps_body(player)):
			camera_tween = create_tween();
			camera_tween.tween_property($Camera2D,"position",Vector2(1920.0/2.0 - 3*1920.0/4.0,1080.0/2.0 - 3*1080.0/4.0),camera_pan_speed);
			camera_tween.finished.connect(camera_tween_done);
		if($Area2.overlaps_body(player)):
			camera_tween = create_tween();
			camera_tween.tween_property($Camera2D,"position",Vector2(1920.0/2.0 + 3*1920.0/4.0,1080.0/2.0 + 3*1080.0/4.0),camera_pan_speed);
			camera_tween.finished.connect(camera_tween_done);
		if($Area3.overlaps_body(player)):
			camera_tween = create_tween();
			camera_tween.tween_property($Camera2D,"position",Vector2(1920.0/2.0 - 3*1920.0/4.0,1080.0/2.0 + 3*1080.0/4.0),camera_pan_speed);
			camera_tween.finished.connect(camera_tween_done);
		if($Area4.overlaps_body(player)):
			camera_tween = create_tween();
			camera_tween.tween_property($Camera2D,"position",Vector2(1920.0/2.0 + 3*1920.0/4.0,1080.0/2.0 - 3*1080.0/4.0),camera_pan_speed);
			camera_tween.finished.connect(camera_tween_done);
		if($CommonArea.overlaps_body(player)):
			camera_tween = create_tween();
			camera_tween.tween_property($Camera2D,"position",Vector2(1920.0/2.0,1080.0/2.0),camera_pan_speed);
			camera_tween.finished.connect(camera_tween_done);

func camera_tween_done():
	camera_tween = null;
