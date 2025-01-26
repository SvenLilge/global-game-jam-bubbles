extends Control

signal message_finished

var emotions_lab = {
	Bubble.EMOTION.ANGER: "Anger",
	Bubble.EMOTION.SADNESS: "Sadness",
	Bubble.EMOTION.JOY: "Joy",
}

var class_lab = {
	Bubble.BUB_CLASS.YOU: "You_",
	Bubble.BUB_CLASS.RELATIVE: "Relatives_",
	Bubble.BUB_CLASS.DUDE: "Dude_",
	Bubble.BUB_CLASS.BOSS: "Boss_",
	Bubble.BUB_CLASS.FRIEND: "Friend_",
	Bubble.BUB_CLASS.DOG: "Joy",
	Bubble.BUB_CLASS.BABY: "Baby",
	Bubble.BUB_CLASS.RANDOM: "Random",
}

var themes = {
	Bubble.EMOTION.JOY: preload("res://resources/themes/joy.tres"),
	Bubble.EMOTION.ANGER: preload("res://resources/themes/angry.tres"),
	Bubble.EMOTION.SADNESS: preload("res://resources/themes/sad.tres"),
}

var replics = {
	"Anger": ["Argh!","Damn!","Crap!","Sheesh!","Seriously?!","What now?!",],
	"Sadness": ["Ahhh...","Sob...","Sigh...","Oh no...","Please...","Why...",],
	"Joy": ["Yippee","Yay","Whoa","Sweet","Lovely","Fantastic",],
	"You_Anger": ["Screw you!","Screw this!","Oh, come on!","Hell no!","Are you kidding?!","Whatever!",],
	"You_Sadness": ["So sad...","I’m heartbroken...","This hurts me...","I can’t believe this...","So unfair...","I can’t take this...",],
	"You_Joy": ["I love this!","That’s amazing!","Oh, wow!","I’m thrilled!","Couldn’t be better!","Best day ever!",],
	"Relatives_Anger": ["Stop it!","Enough!","How many times?!","Not again!","Cut it out!","For god's sake!",],
	"Relatives_Sadness": ["So sad...","Disappointing...","How could you?..","This isn’t like you...","This hurts me...","I can’t believe this...",],
	"Relatives_Joy": ["I’m so proud!","You did it!","That’s my kid!","Well done!","You’re amazing!","I love you!",],
	"Dude_Anger": ["Bloody hell!","Screw you!","Shut up!","Screw this!","For heaven’s sake!","Piss off!",],
	"Dude_Sadness": ["How could this be?","So sad...","So unfair...","I can’t take this...","This is unbearable...","I feel so alone...",],
	"Dude_Joy": ["I love this!","That’s amazing!","Oh, wow!","I’m thrilled!","Couldn’t be better!","Best day ever!",],
	"Boss_Anger": ["Unacceptable!","Nonsense!","Ridiculous!","Seriously?!","I’m losing patience!","Do your job!",],
	"Boss_Sadness": ["I expected better...","Disappointing...","So sad...","Such a shame...","This is frustrating...","We've lost it...",],
	"Boss_Joy": ["What a win!","Well done!","You’ve got this!","You nailed it!","Outstanding!","Great job!",],
	"Friend_Anger": ["Come on!","Really now?!","Stop it!","For god's sake!","Enough!","Are you kidding?!",],
	"Friend_Sadness": ["So unfair...","I’m heartbroken...","I can’t take this...","This isn’t like you...","This hurts me...","I can’t believe this...",],
	"Friend_Joy": ["I love you!","You’re amazing!","I love this!","You make me happy","Oh, wow!","That’s amazing!",],
	"Dogs_woof": ["Woof","Ruff","Arf","Bow-wow","Grrrruff","Arroo",],

	"Anger_2_Anger": ["Piss off!","You’re full of sh-!","Back off!","What’s your problem?!","Look who’s talking!","I’m done with this BS!",],
	"Anger_2_Sadness": ["Grow up already!","I’m sick of this!","Stop being dramatic!","Get over it!","Not my problem!","Pull yourself together!",],
	"Anger_2_Joy": ["Nobody cares!","Keep it to yourself!","Shut your mouth!","Big whoop!","Annoying!","So what?!",],
	"Sadness_2_Anger": ["Why me?","This hurts me...","How could you?..","Please don’t yell…","I’m really trying…","So harsh...",],
	"Sadness_2_Sadness": ["This isn’t fair…","This is so hard…","Why is this happening?","I know…","I feel broken too…","I feel the same…",],
	"Sadness_2_Joy": ["Must be nice...","Good for you…","I wish I felt the same…","That’s nice, I guess…","Lucky you…","Enjoy it while it lasts…",],
	"Joy_2_Anger": ["Love the energy!","Relax, it’s all good!","You crack me up!","That’s adorable!","Calm down, buddy!","Thanks for the laugh!",],
	"Joy_2_Sadness": ["You’ll be fine!","Cheer up!","Life’s too short!","I believe in you!","I’m here for you!","Hang in there!",],
	"Joy_2_Joy": ["Me too!","That’s awesome!","Love it!","High five!","Heck yeah!","Go us!",],
	"Baby": ["Ah wah","Goo goo","Buh buh","Ah goo","La la","Hee hee",],
	"Random": ["Gotcha!","Ok, thanks!","I agree!","If you say so!","Refreshing!","Noted!",],
}

var tutorial = {
	0_0: [Bubble.EMOTION.JOY, ["You are a bubble.", "The Bubble.", "You appeared in this word as a pure bubble.", "Blank state. Tabula Rasa.", "Use arrows/WASD to move"]],
	0_1: [Bubble.EMOTION.JOY, ["The world has other bubbles. They affect you.", "Some of them bring joy, like this one."]],
	0_2: [Bubble.EMOTION.ANGER, ["Some of them spread anger.", "They also move differently."]],
	0_3: [Bubble.EMOTION.SADNESS, ["And some - spread sadness.", "Choose your company wisely."]],
	1_0: [Bubble.EMOTION.JOY, [
		"Your bubble grew up a bit.\nIt remembers all past encounters.", "But it also is open to the new ones.\nMoreover - now you have things to do.",
		"You need to rest to survive.\nYou rest at home.", "You need to have some fun to keep spirits up.", 
		"You need to study, for you future.\nAt school.", "And make meaningful connections.\nSpend time with a close friend.",
		"Moreover, now you also affect others.\nJust a little bit.",
	]],
	2_0: [Bubble.EMOTION.ANGER, ["You grow. Things get messy.", "You need to endure to persist."]],
	3_0: [Bubble.EMOTION.JOY, ["Who's a big bubble now?", "You are!", "Now you earn thingy called money.", "Did you study well?"]],
	4_0: [Bubble.EMOTION.JOY, ["Your bubble had its time.", "You persist. But what for?", "Time to spread yourself to other bubbles...", "Or better not?"]],
	5_0: [Bubble.EMOTION.SADNESS, ["Your time is over.", "Time to pop your bubble", "Time to look what's inside.", "Will you like it?"]],
}


var final_bubble = {
	0: { #dominant emotion
		"Joy": [Bubble.EMOTION.JOY, "You barely remember your first months.\nBut you recall they were full of joy."],
		"Anger": [Bubble.EMOTION.ANGER, "You barely remember your first months.\nBut you recall they were full of anger."],
		"Sad": [Bubble.EMOTION.SADNESS, "You barely remember your first months.\nBut you recall they were full of sadness."],
		"Bittersweet": [Bubble.EMOTION.JOY, "You barely remember your first months.\nBut you recall they were full of everything."],
		"Depressed": [Bubble.EMOTION.SADNESS, "You barely remember your first months.\nBut you recall they were full of suffering."],
	},
	1_1: { #first educ/money, second personal.
		"Low_Low": [Bubble.EMOTION.ANGER, "You had hard times in your childhood.\nBoth with studies and with forming connections."],
		"Low_High": [Bubble.EMOTION.JOY, "Who cares about studying as a child?\nNot you! You cared about making friends!"],
		"High_Low": [Bubble.EMOTION.SADNESS, "You studied really hard as a child.\nBut did you make friends?"],
		"High_High": [Bubble.EMOTION.JOY, "You did really well in your childhood.\nSome call it talent. You call it effort."],
	},
	1_2: { #dominant emotion
		"Joy": [Bubble.EMOTION.JOY, "But it was a happy time.\nMaybe the easiest in your life."],
		"Anger": [Bubble.EMOTION.ANGER, "Your bubble got the first\nangry seeds at that time."],
		"Sad": [Bubble.EMOTION.SADNESS, "Your childhood memories are mostly\nblue."],
		"Depressed": [Bubble.EMOTION.SADNESS, "Some people had happy childhood...\nClearly not you."],
		"Bittersweet": [Bubble.EMOTION.JOY, "You've had some moments of joy,\nand some of sadness or even anger."],
		
	},
	2_1: { #first educ/money, second personal.
		"Low_Low": [Bubble.EMOTION.SADNESS, "They say teenage years are the hardest.\nThey clearly were hard for you."],
		"Low_High": [Bubble.EMOTION.JOY, "Studies weren't your strong side as a teen.\nBut it is human connection that matters!"],
		"High_Low": [Bubble.EMOTION.ANGER, "You've made books your second home.\nFriends? You'll deal with that later, right?"],
		"High_High": [Bubble.EMOTION.JOY, "Your teenage years marked the path for\nyour future success. Did it work out?"],
	},
	2_2: { #dominant emotion
		"Joy": [Bubble.EMOTION.JOY, "And what matters most\n - it was a happy time"],
		"Anger": [Bubble.EMOTION.ANGER, "It was too hard to avoid\nall the hatred around."],
		"Sad": [Bubble.EMOTION.SADNESS, "Who showed you that sad song?\nIt became your teen's soundtrack."],
		"Depressed": [Bubble.EMOTION.SADNESS, "Survival - that was your motto.\nTeenage years hit you real hard."],
		"Bittersweet": [Bubble.EMOTION.JOY, "Those times were rich,\nyou've had it all - joy, anger, sadness."],
		
	},
	3_1: { #first educ/money, second personal.
		"Low_Low": [Bubble.EMOTION.SADNESS, "How are you even supposed to succeed\nin these unfair times, anyway?"],
		"Low_High": [Bubble.EMOTION.JOY, "You didn't go for that rat race.\nWho cares about money? People matter."],
		"High_Low": [Bubble.EMOTION.ANGER, "You got a brilliant career.\nPeople? They are just envious."],
		"High_High": [Bubble.EMOTION.JOY, "Who said you can't have it all?\nYou clearly had it."],
	},
	3_2: { #dominant emotion
		"Joy": [Bubble.EMOTION.JOY, "The world is full of joy.\nYou just need to seek properly."],
		"Anger": [Bubble.EMOTION.ANGER, "In this world of assholes...\nHow can you avoid becoming one?"],
		"Sad": [Bubble.EMOTION.SADNESS, "You feel this world is screwed.\nIt's sad. What else could it be?"],
		"Depressed": [Bubble.EMOTION.SADNESS, "Life is harsh. Screw it.\nWas it even worth it?"],
		"Bittersweet": [Bubble.EMOTION.JOY, "You've embraced the world\nin all its complexity."],
		
	},
	4_1: { #first educ/money, second personal.
		"Low_Low": [Bubble.EMOTION.SADNESS, "You wanted to share what you had.\nBut did you have enough to share?"],
		"Low_High": [Bubble.EMOTION.JOY, "It was the time to spread the love.\nYou tried your best."],
		"High_Low": [Bubble.EMOTION.ANGER, "You've learned and achieved a lot.\nPeople? They should learn from you."],
		"High_High": [Bubble.EMOTION.JOY, "You aced both career and personal\nYou've even managed to spread some."],
	},
	4_2: { #dominant emotion
		"Joy": [Bubble.EMOTION.JOY, "This was the time to spread joy.\nAnd you had the joy to spread."],
		"Anger": [Bubble.EMOTION.ANGER, "They called you angry?\nYou called it bringing truth."],
		"Sad": [Bubble.EMOTION.SADNESS, "They need to know it. To feel it.\nThe pain of the world."],
		"Depressed": [Bubble.EMOTION.SADNESS, "Spreading the hatred?\nThis world deserved it."],
		"Bittersweet": [Bubble.EMOTION.JOY, "Live is complex. Yours was.\nThey need to learn about it"],
		
	},
}


var tutorial_playing = false
var mess_mass = ""

@onready var lab:Label = $Label
@onready var delay_timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func test_tut():
	for mes in tutorial:
		play_tutorial(mes)
		await message_finished


func test_respond():
	for emot1 in Bubble.EMOTION.size():
		for emot2 in Bubble.EMOTION.size():
		
			respond(emot1, emot2)
			await get_tree().create_timer(1.0).timeout
	
	respond(Bubble.BUB_CLASS.BABY)
	await get_tree().create_timer(1.0).timeout
	respond(Bubble.BUB_CLASS.RANDOM)


func test_say():
	for bub_cl in Bubble.BUB_CLASS.size():
		for emot in Bubble.EMOTION.size():
		
			say_emotion(bub_cl, emot)
			await get_tree().create_timer(1.0).timeout


func play_last(code, result):
	lab.custom_minimum_size = Vector2(360, 100)
	var emotion = final_bubble[code][result][0]
	theme = themes[emotion]
	lab.text = final_bubble[code][result][1]
	

func play_tutorial(code):
	tutorial_playing = true
	if code in tutorial:
		delay_timer.start(0.15)
		var emotion = tutorial[code][0]
		mess_mass = tutorial[code][1]
		theme = themes[emotion]
		lab.text = mess_mass.pop_front()
	else:
		push_warning("no such code")


func play_next_line():
	delay_timer.start(0.15)
	lab.text = mess_mass.pop_front()


func say_emotion(who, emotion = null):
	if who == Bubble.BUB_CLASS.DOG:
		lab.text = replics["Dogs_woof"].pick_random()
		theme = themes[Bubble.EMOTION.JOY]
	else:
		if (class_lab[who] + emotions_lab[emotion]) not in replics:
			push_warning("no reply for " + class_lab[who] + emotions_lab[emotion])
			return
		
		var list_name = replics[class_lab[who] + emotions_lab[emotion]]
		list_name += replics[emotions_lab[emotion]]
		theme = themes[emotion]
		lab.text = list_name.pick_random()
		decay()


func respond(with_emotion, to_emotion = null):
	if with_emotion == Bubble.BUB_CLASS.BABY:
		lab.text = replics["Baby"].pick_random()
		theme = themes[to_emotion]
	elif with_emotion == Bubble.BUB_CLASS.RANDOM:
		lab.text = replics["Random"].pick_random()
		theme = themes[to_emotion]
	elif with_emotion == Bubble.BUB_CLASS.RANDOM:
		lab.text = replics["Dogs_woof"].pick_random()
		theme = themes[to_emotion]
	
	else:
		var list_name = replics[emotions_lab[with_emotion] + "_2_" + emotions_lab[to_emotion]]
		theme = themes[with_emotion]
		lab.text = str(list_name.pick_random())
		decay()
		
		

func decay(time = 1.0):
	message_finished.emit()
	delay_timer.start(time)
	await delay_timer.timeout
	var tween_modul = get_tree().create_tween()
	tween_modul.tween_property(self, "modulate", Color(1,1,1,0), 0.6 * time).set_trans(Tween.TRANS_SINE)
	tween_modul.tween_callback(queue_free)
	


func _input(event: InputEvent) -> void:
	if visible and delay_timer.time_left == 0 and tutorial_playing:
		if ((event is InputEventMouseButton) or (event is InputEventKey) or (event is InputEventJoypadButton)) and event.is_released():
			if mess_mass.size() > 0:
				delay_timer.start(0.15)
				play_next_line()
			else:
				tutorial_playing = false
				decay(0.5)
				
func _unhandled_input(_event: InputEvent) -> void:
	if tutorial_playing:
		get_viewport().set_input_as_handled()
