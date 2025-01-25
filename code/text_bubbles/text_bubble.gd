extends Node2D

var emotions_lab = {
	Bubble.EMOTION.ANGER: "Anger",
	Bubble.EMOTION.SADNESS: "Sadness",
	Bubble.EMOTION.JOY: "Joy",
}

var class_lab = {
	Bubble.EMOTION.ANGER: "Anger",
	Bubble.EMOTION.SADNESS: "Sadness",
	Bubble.EMOTION.JOY: "Joy",
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
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func say_emotion(who, emotion):
	pass
	

func respond(to_emotion, with_emotion):
	pass
