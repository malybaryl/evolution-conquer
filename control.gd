extends Control

@export var background = false
@export var play_music = false
var main_menu_scene_str = "res://Scenes/main_menu.tscn"

func _ready() -> void:
	if background:
		var animator = get_node("CanvasLayer/Background_space/AnimationPlayer")
		animator.play("bg moving")
	else:
		var background = get_node("CanvasLayer/Background_space")
		background.queue_free()
	
	if play_music:
		var music = get_node("AudioStreamPlayer")
		music.volume_db = (Global.float_to_db(Global.MUSIC))
		music.play_song()
	
	var credits_animation = get_node("CreditsAnimation")
	credits_animation.play("credits_animation")
	


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_scene_str)
