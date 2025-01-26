extends CanvasLayer


@onready var energy = $Control/Energy
@onready var entertainment = $Control/Entertainment
@onready var education = $Control/Education
@onready var money = $Control/Money
@onready var personal = $Control/Personal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_hud()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func reset_hud():
	set_energy(0)
	set_entertainment(0)
	set_education(0)
	set_money(0)
	set_personal(0)
	

func set_energy(value):
	energy.text = str(value) + "/10"


func set_entertainment(value):
	entertainment.text = str(value) + "/10"


func set_education(value):
	education.text = str(value)


func set_money(value):
	money.text = str(value)


func set_personal(value):
	personal.text = str(value)
	
	
