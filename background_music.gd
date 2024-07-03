extends CanvasLayer

onready var credits := $Label
onready var music_bg := $AudioStreamPlayer2D

const music_credts:= [
	'[center]Music by [url="https://pixabay.com/users/fassounds-3433550/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=112191"]FASSounds[/url] from [url="https://pixabay.com/music//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=112191"]Pixabay[/url]',
	'[center]Music by [url="https://pixabay.com/users/chillmore-25283030/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=110111"]Chillmore[/url] from [url="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=110111"]Pixabay[/url]',
	'[center]Music by [url="https://pixabay.com/users/chillmore-25283030/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=15582"]Chillmore[/url] from [url="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=15582"]Pixabay[/url]',
	'[center]Music by [url="https://pixabay.com/users/soulprodmusic-30064790/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=123089"]Oleg Fedak[/url] from [url="https://pixabay.com/music//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=123089"]Pixabay[/url]',
	'[center]Music by [url="https://pixabay.com/users/soulprodmusic-30064790/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=122874"]Oleg Fedak[/url] from [url="https://pixabay.com/music//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=122874"]Pixabay[/url]',
	'[center]Music by [url="https://pixabay.com/users/lesfm-22579021/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=137769"]Oleksii Kaplunskyi[/url] from [url="https://pixabay.com//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=137769"]Pixabay[/url]',
	'[center]Music by [url="https://pixabay.com/users/lorenzobuczek-16982400/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=202113"]LAURENT BUCZEK[/url] from [url="https://pixabay.com/music//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=202113"]Pixabay[/url]'
]

const music := [
	preload("res://MusicAndSoundEffects/music/chill-study-15582.mp3"), preload("res://MusicAndSoundEffects/music/close-study-relax-chillhop-calm-study-lofi-123089.mp3"), preload("res://MusicAndSoundEffects/music/lofi-study-112191.mp3"), preload("res://MusicAndSoundEffects/music/mars-lofi-study-beat-beats-to-relax-chillhop-122874.mp3"), preload("res://MusicAndSoundEffects/music/study-7-m-moszkowski-202113.mp3"), preload("res://MusicAndSoundEffects/music/study-110111.mp3"), preload("res://MusicAndSoundEffects/music/study-sleep-eat-137769.mp3")
]

var music_index = 0

func _ready():
	music_bg.stream = music[music_index]
	credits.bbcode_text = music_credts[music_index]
	music_bg.play()

func _on_AudioStreamPlayer2D_finished():
	music_index = (music_index + 1) % 7
	music_bg.stream = music[music_index]
	credits.bbcode_text = music_credts[music_index]
	music_bg.play()
	
