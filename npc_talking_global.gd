extends Node

var ai_is_talking := false

var ai_talking_lines := {
	1:["Oh, hello there!","It seems that you are new to learning Calculus!",
		"Nice to meet you, I'm...", "Huh, that's weird...", "I don't remember my name...",
		"Don't worry! I'll figure out my name soon.", "In the meantime, why don't you go to the next level?",
		"Maybe I'll find my name out through the game files!"],
	2:["Hey! I'm back!", "Good news! I know my name!", "My name is Sally!",
		"I am your personal assistant in helping you learning Calculus!"]
}

var ai_talking_emotions := {
	1:[0,0,0,4,4,1,0,0],
	2:[]
}
