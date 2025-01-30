extends Node

# Used across the game
var sfx = 0.8
var music = 0.8
var st_music = 0.8
var em_music = 0.8
var loc_music = 0.8

# Game option reset states
var reset_sfx = 0.8
var reset_music = 0.8
var reset_st_music = 0.8
var reset_em_music = 0.8
var reset_loc_music = 0.8

var route = "user://config.dat"

func _ready() -> void:
	load_config()
	set_all_setting()


func save_config():
	"""
	Saves the map to a file.
	"""
	# make config dict:
	var config_dict = {
		"sfx": sfx,
		"music": music,
		"st_music": st_music,
		"em_music": st_music,
		"loc_music": loc_music,
	}
	
	# save config to file
	var file = FileAccess.open(route, FileAccess.WRITE)
	file.store_var(config_dict)
	

func load_config():
	"""
	Loads the map from a file.
	"""
	var file = FileAccess.open(route, FileAccess.READ)
	if file:
		var config_dict = file.get_var()
		
		sfx = config_dict["sfx"]
		music = config_dict["music"]
		st_music = config_dict["st_music"]
		em_music = config_dict["em_music"]
		loc_music = config_dict["loc_music"]


func set_all_setting():
	set_sfx(sfx)
	set_music(music)

	set_st_music(st_music)
	set_em_music(em_music)
	set_loc_music(loc_music)


func set_sfx(value):
	var bus_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

func set_music(value):
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func set_st_music(value):
	var bus_index = AudioServer.get_bus_index("Stage")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func set_em_music(value):
	var bus_index = AudioServer.get_bus_index("Emotion")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func set_loc_music(value):
	var bus_index = AudioServer.get_bus_index("Location")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
