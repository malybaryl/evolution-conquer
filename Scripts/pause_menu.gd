extends Control

var main_menu_scene_str = "res://Scenes/main_menu.tscn"
var can_by_audio_played = true 
var button_audio
var slider_music
var slider_sfx
var ready_bus_music = false
var ready_bus_sfx = false
var bus_music
var bus_sfx

func _ready() -> void:
	button_audio = get_node("CanvasLayer/AudioButton")
	slider_music = get_node("CanvasLayer/VBoxContainer3/HBoxContainer2/HSlider")
	slider_sfx = get_node("CanvasLayer/VBoxContainer3/HBoxContainer3/HSlider2")
	slider_music.value = Global.MUSIC
	slider_sfx.value = Global.SFX
	bus_music = AudioServer.get_bus_index("Music")
	bus_sfx = AudioServer.get_bus_index("Sfx")

	
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


func _on_h_slider_value_changed(value: float) -> void:
	if ready_bus_music:
		if value != null:
			Global.MUSIC = value
			AudioServer.set_bus_volume_db(
				bus_music,
				linear_to_db(value)
			)
	if !ready_bus_music:
		ready_bus_music = true
	Global.write_savegame()


func _on_h_slider_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_h_slider_mouse_exited() -> void:
	can_by_audio_played = true


func _on_h_slider_2_value_changed(value: float) -> void:
	if ready_bus_sfx:
		if value != null:
			Global.SFX = value
			AudioServer.set_bus_volume_db(
				bus_sfx,
				linear_to_db(value)
			)
	if !ready_bus_sfx:
		ready_bus_music = true
	Global.write_savegame()



func _on_h_slider_2_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false



func _on_h_slider_2_mouse_exited() -> void:
	can_by_audio_played = true


func _on_check_button_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false



func _on_check_button_mouse_exited() -> void:
	can_by_audio_played = true
