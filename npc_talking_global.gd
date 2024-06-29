extends Node

var will_talk := false
var dialogue_number := 0

var ai_talking_lines := {
	1:["Oh, hello there!","It seems that you are new to learning Calculus!",
		"Nice to meet you, I'm...", "Huh, that's weird...", "I don't remember my name...",
		"Don't worry! I'll figure out my name soon.", "In the meantime, why don't you go to the next level?",
		"Maybe I'll find my name out through the game files!"],
	2:["Hey! I'm back!", "Good news! I remember something!", "I am tasked... to be in this game!",
		"I am your personal assistant in helping you learning Calculus!","...",
		"...that's all I remember, for now...", "Sorry, I was hoping I can remember more...",
		"Maybe if you beat more levels, I can learn more about myself!"],
	3:["Hey hey! Here I am again!","So, I found something interesting!","I can't explain it to you properly, but...",
		"Everytime you beat a level, a file is recovered.","It's as if the level repairs the game itself.",
		"Do you think the developers do this on purpose?","I'm not sure, but I'm glad that you're helping me out!"],
		
}

#	0:"default",
#	1:"happy",
#	2:"sad",
#	3:"angry",
#	4:"confused"

var ai_talking_emotions := {
	1:[0,0,0,4,4,1,0,0],
	2:[0,0,1,1,0,0,2,0],
	3:[]
}

