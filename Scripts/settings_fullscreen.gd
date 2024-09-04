extends Label

var fullscreen

func _ready() -> void:
	fullscreen = Global.fullscreen
	if fullscreen:
		text = 'fullscreen'
	else:
		text = 'windowed'
