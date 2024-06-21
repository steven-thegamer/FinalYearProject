extends HSplitContainer
onready var label = $Label
func _process(delta):
	label.text = str(GameLevelProgress.money)
