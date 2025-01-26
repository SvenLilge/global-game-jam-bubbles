extends CanvasLayer


var stage_timers = {
	0: 3,
	1: 2.5,
	2: 9,
	3: 7.5,
	4: 8
}


@onready var energy = $Control/Energy
@onready var entertainment = $Control/Entertainment
@onready var education = $Control/Education
@onready var money = $Control/Money
@onready var personal = $Control/Personal

@onready var age: Label = $Control/Age
@onready var age_timer = $AgeCounter
var cur_stage = 0
var cur_age

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
	set_age(0)
	age_timer.timeout.connect(on_timeout)
	
	#hide all
	energy.hide()
	entertainment.hide()
	money.hide()
	education.hide()
	personal.hide()


func start_age_counter(stage_num):
	cur_stage = stage_num
	match cur_stage:
		0:
			cur_age = 0
		1:
			cur_age = 60
		2:
			cur_age = 10
		3:
			cur_age = 20
		4:
			cur_age = 40
		5:
			cur_age = 80
	
	if cur_stage < 5:
		age_timer.start(stage_timers[cur_stage])


func on_timeout():
	match cur_stage:
		0:
			cur_age += 1
		1:
			cur_age += 1
		2:
			cur_age += 0.5
		3:
			cur_age += 0.5
		4:
			cur_age += 1
	
	set_age(cur_age)


func set_age(value):
	if value > 0:
		var tween_modul = get_tree().create_tween()
		tween_modul.tween_property(age, "modulate", Color(0,0,0,1), 0.4).set_trans(Tween.TRANS_SINE)
		await tween_modul.finished
	
	match cur_stage:
		0:
			age.text = str(value) + " Months"
		1:
			var years = floor(value/12)
			var months = value % 12
			age.text = str(years) + " Years, " + str(months) + " Months"
		_: 
			age.text = str(value) + " Years"
	
	if value > 0:
		var tween_modul = get_tree().create_tween()
		tween_modul.tween_property(age, "modulate", Color(1,1,1,1), 0.8).set_trans(Tween.TRANS_SINE)
		await tween_modul.finished
		


func set_energy(value):
	if value > 0:
		energy.show()
		
	energy.text = str(value) + "/10"


func set_entertainment(value):
	if value > 0:
		entertainment.show()
		
	entertainment.text = str(value) + "/10"


func set_education(value):
	if value > 0:
		education.show()
		
	education.text = str(value)


func set_money(value):
	if value > 0:
		money.show()
		
	money.text = str(value)


func set_personal(value):
	if value > 0:
		personal.show()
	personal.text = str(value)
	
	
