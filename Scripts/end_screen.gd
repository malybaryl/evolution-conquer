extends Control

var sun_face_animation
var audio

@onready var credits = preload("res://Scenes/control.tscn")

func _ready() -> void:
	# audio 
	audio = get_node("AudioStreamPlayer")
	
	# animations
	var background_animation = get_node("Background_space/AnimationPlayer")
	background_animation.play("bg moving")
	
	var sun_animation = get_node("CanvasLayer/Sun2/AnimationPlayer")
	sun_animation.play("sun_animation")
	
	sun_face_animation = get_node("CanvasLayer/SunFace")
	sun_face_animation.play("default")


func _on_sun_face_animation_finished() -> void:
	audio.play_song()
	sun_face_animation.play("drink")
	var init = credits.instantiate()
	init.background = false
	init.play_music = false
	add_child(init)
	
	

	
