extends Node2D

onready var camera = $Camera2D

var scroll_speed = 10

onready var level_button_1 = $level_button
onready var level_button_2 = $level_button2
onready var level_button_3 = $level_button3
onready var level_button_4 = $level_button4
onready var level_button_5 = $level_button5
onready var level_button_6 = $level_button6
onready var level_button_7 = $level_button7
onready var level_button_8 = $level_button8
onready var level_button_9 = $level_button9
onready var level_button_10 = $level_button10


# Called when the node enters the scene tree for the first time.
func _ready():
	level_button_1.disabled = !GameLevelProgress.chap_1_level_progress[1].unlocked
	level_button_2.disabled = !GameLevelProgress.chap_1_level_progress[2].unlocked
	level_button_3.disabled = !GameLevelProgress.chap_1_level_progress[3].unlocked
	level_button_4.disabled = !GameLevelProgress.chap_1_level_progress[4].unlocked
	level_button_5.disabled = !GameLevelProgress.chap_1_level_progress[5].unlocked
	level_button_6.disabled = !GameLevelProgress.chap_1_level_progress[6].unlocked
	level_button_7.disabled = !GameLevelProgress.chap_1_level_progress[7].unlocked
	level_button_8.disabled = !GameLevelProgress.chap_1_level_progress[8].unlocked
	level_button_9.disabled = !GameLevelProgress.chap_1_level_progress[9].unlocked
	level_button_10.disabled = !GameLevelProgress.chap_1_level_progress[10].unlocked
	
func _process(delta):
	camera.position.y = clamp(camera.position.y,-1600,0)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			camera.position.y -= scroll_speed
		elif event.button_index == BUTTON_WHEEL_DOWN:
			camera.position.y += scroll_speed
