extends Control

var mainmenu_scene_str = "res://Scenes/main_menu.tscn"
var credits_scene_str = "res://Scenes/control.tscn"
var transition

var cliked_back_button = false
var cliked_credits_button = false

var bus_music
var bus_sfx
var ready_bus_music = false
var ready_bus_sfx = false
var can_by_audio_played = true
var button_audio

func _ready() -> void:
	var fullscreen_node = get_node("CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer4/Label4")
	var resolution_node = get_node("CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer/Change") as Button
	var bg_anim = get_node("CanvasLayer/Background_space/AnimationPlayer")
	var slider_music = get_node("CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer2/HSlider") as HSlider
	var slider_sfx= get_node("CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer3/HSlider2") as HSlider
	var resolution_text_node = get_node("CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer/Label4") as Label
	button_audio = get_node("Button")
	slider_music.value = Global.MUSIC
	slider_sfx.value = Global.SFX
	bg_anim.play("bg moving")
	transition = get_node("CanvasLayer/Transition/Transition")
	transition.play("transition")
	bus_music = AudioServer.get_bus_index("Music")
	bus_sfx = AudioServer.get_bus_index("Sfx")
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen"):
			Global.fullscreen = !Global.fullscreen
			if Global.fullscreen:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			else:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_back_pressed() -> void:
	cliked_back_button = true
	transition.play_backwards("transition")
	Global.write_savegame()


func _on_credits_pressed() -> void:
	cliked_credits_button = true
	transition.play_backwards("transition")


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


func _on_h_slider_2_value_changed(value: float) -> void:
	if ready_bus_sfx:
		if value != null:
			Global.SFX = value
			AudioServer.set_bus_volume_db(
				bus_sfx,
				linear_to_db(value)
			)
	if !ready_bus_sfx:
		ready_bus_sfx = true


func _on_save_pressed() -> void:
	var resolution_node = get_node("CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer/Label4")
	var resolution = resolution_node.return_resolution()
	var resolution_index = resolution_node.return_resolution_index()
	Global.resolution = resolution
	Global.resolution_index = resolution_index
	DisplayServer.window_set_size(Vector2i(resolution[0], resolution[1]))
	if Global.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		# privent from buging
		var timer = Timer.new()
		timer.wait_time = .1
		timer.one_shot = true
		add_child(timer)
		timer.start()

		# Używamy await, aby poczekać na zakończenie timera
		await timer.timeout
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	


func _on_transition_animation_finished(anim_name: StringName) -> void:
	if cliked_back_button:
		get_tree().change_scene_to_file(mainmenu_scene_str)
	elif cliked_credits_button:
		get_tree().change_scene_to_file(credits_scene_str)
		


func _on_change_fullscreen_pressed() -> void:
	Global.fullscreen = !Global.fullscreen
	var fullscreen_node = get_node("CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer4/Label4")
	var resolution_node_button = get_node("CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer/Change") as Button
	var resolution_node = get_node("CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer/Label4") as Label

	if Global.fullscreen:
		fullscreen_node.text = 'fullscreen'
		resolution_node_button.disabled = true
		resolution_node.text = "------"
	else:
		fullscreen_node.text = 'windowed'
		resolution_node_button.disabled = false
		var resolution = resolution_node.return_resolution()
		resolution_node.text = str(resolution[0]) + "x" + str(resolution[1])


func _on_button_finished() -> void:
	can_by_audio_played = true


func _on_back_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_back_mouse_exited() -> void:
	can_by_audio_played = true


func _on_credits_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_credits_mouse_exited() -> void:
	can_by_audio_played = true


func _on_h_slider_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_h_slider_mouse_exited() -> void:
	can_by_audio_played = true


func _on_h_slider_2_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_h_slider_2_mouse_exited() -> void:
	can_by_audio_played = true


func _on_change_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_change_mouse_exited() -> void:
	can_by_audio_played = true


func _on_save_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_save_mouse_exited() -> void:
	can_by_audio_played = true


func _on_check_button_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_check_button_mouse_exited() -> void:
	can_by_audio_played = true
