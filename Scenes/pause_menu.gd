extends Control

var main_menu_scene_str = "res://Scenes/main_menu.tscn"
var can_by_audio_played = true 
var button_audio

func _ready() -> void:
	# audio
	button_audio = get_node("CanvasLayer/AudioButton")
	button_audio.volume_db = (Global.float_to_db(Global.SFX))
	
func _on_back_pressed() -> void:
	queue_free()
	Engine.time_scale = 1
	get_tree().change_scene_to_file(main_menu_scene_str)


func _on_back_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_back_mouse_exited() -> void:
	can_by_audio_played = true


func _on_audio_button_finished() -> void:
	can_by_audio_played = true
