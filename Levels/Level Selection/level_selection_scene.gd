extends Node2D

onready var camera = $Camera2D
onready var display_level = $CanvasLayer/display_level
onready var coin_ui = $CanvasLayer/coin_ui
onready var shop_button = $CanvasLayer/shop_button
onready var shop_pop_up = $CanvasLayer/shop

var scroll_speed = 10
var active := true

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
	
	level_button_1.connect("display_title_and_desc",self,"display_level_description")
	level_button_2.connect("display_title_and_desc",self,"display_level_description")
	level_button_3.connect("display_title_and_desc",self,"display_level_description")
	level_button_4.connect("display_title_and_desc",self,"display_level_description")
	level_button_5.connect("display_title_and_desc",self,"display_level_description")
	level_button_6.connect("display_title_and_desc",self,"display_level_description")
	level_button_7.connect("display_title_and_desc",self,"display_level_description")
	level_button_8.connect("display_title_and_desc",self,"display_level_description")
	level_button_9.connect("display_title_and_desc",self,"display_level_description")
	level_button_10.connect("display_title_and_desc",self,"display_level_description")

	if GameLevelProgress.chap_1_level_progress[1].completed == true:
		coin_ui.show()
		shop_button.show()

func display_level_description(title,description,path,level_code):
	SoundEffects.click_audio_play()
	display_level.level_code_selection = level_code
	display_level.update_text(title,description)
	display_level.scene_path = path
	display_level.show()

func _process(delta):
	camera.position.y = clamp(camera.position.y,-1600,0)
	active = !display_level.visible

func _input(event):
	if event is InputEventMouseButton and active:
		if event.button_index == BUTTON_WHEEL_UP:
			camera.position.y -= scroll_speed
		elif event.button_index == BUTTON_WHEEL_DOWN:
			camera.position.y += scroll_speed

func _on_TextureButton_pressed():
	if active:
		SoundEffects.click_audio_play()
		get_tree().change_scene("res://main_menu/main_menu.tscn")

func _on_shop_button_pressed():
	SoundEffects.click_audio_play()
	active = false
	shop_pop_up.show()
