extends Node

var will_talk := false
var dialogue_number := 0

var ai_talking_lines := {
	1:["Huh?","Oh! Hello there!", "I'm wide awake thanks to you!", "I don't remember how long I was asleep!",
		"But boy am I glad that you wake me up!", "My name is...","Uhh... I don't remember...", "Oh no... I don't remember who I am...",
		"Wait, I don't even remember why I'm here!", "But, maybe you can help me?", "You did wake up, so I think you can also help me remember something!"],
	2:["Hey! I'm back!", "Good news! I remember something!", "I am... an assistant!",
		"I am your assistant to help you learn Calculus!","...",
		"...that's all I remember, for now...", "Sorry, I was hoping I can remember more...",
		"Maybe if you beat more levels, I can learn more about myself!","Man, what is going on in this game?"],
	3:["Hey hey! Here I am again!","So, I found something interesting!","I can't explain it to you properly, but...",
		"Everytime you beat a level, my memory is coming back!","It's as if the level fixes me.",
		"Do you think the developers do this on purpose?","I'm not sure, but I'm glad that you're helping me out!"],
	5:["Hello hello! I'm back!","I'm running out of catchphrases just to see you again!",
		"Anyway, I found something cool this time!","Apparently, this game was made for a thesis!",
		"Like, a game for a research paper!","Isn't it cool?","...","Sorry, but that's all..."]
}


#	0:"default",
#	1:"happy",
#	2:"sad",
#	3:"angry",
#	4:"confused"

var ai_talking_emotions := {
	1:[0,0,0,0,1,0,4,4,2,2,2],
	2:[0,0,1,1,0,0,2,0,4],
	3:[1,0,4,0,0,1,1],
	5:[1,4,0,0,0,1,0,2]
}
