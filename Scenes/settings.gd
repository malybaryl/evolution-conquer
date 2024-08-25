extends Control

var mainmenu_scene_str = "res://Scenes/main_menu.tscn"
var credits_scene_str = "res://Scenes/control.tscn"
var transition
var music
var sfx

var cliked_back_button = false
var cliked_credits_button = false

func _ready() -> void:
	var bg_anim = get_node("CanvasLayer/Background_space/AnimationPlayer")
	bg_anim.play("bg moving")
	transition = get_node("CanvasLayer/Transition/Transition")
	transition.play("transition")
	var music = get_node("Music")
	if music:
		music.volume_db = (Global.float_to_db(Global.MUSIC))
	var sfx = get_node("SFX")
	if sfx:
		sfx.volume_db = (Global.float_to_db(Global.SFX))


func _on_back_pressed() -> void:
	cliked_back_button = true
	transition.play_backwards("transition")


func _on_credits_pressed() -> void:
	cliked_credits_button = true
	transition.play_backwards("transition")


func _on_h_slider_value_changed(value: float) -> void:
	Global.MUSIC = value
	if music:
		music.volume_db = (Global.float_to_db(Global.MUSIC))


func _on_h_slider_2_value_changed(value: float) -> void:
	Global.SFX = value
	if sfx:
		sfx.volume_db = (Global.float_to_db(Global.MUSIC))


func _on_save_pressed() -> void:
	var resolution_node = get_node("CanvasLayer/HBoxContainer/VBoxContainer/HBoxContainer/Label4")
	var resolution = resolution_node.return_resolution()
	DisplayServer.window_set_size(Vector2i(resolution[0], resolution[1]))


func _on_transition_animation_finished(anim_name: StringName) -> void:
	if cliked_back_button:
		get_tree().change_scene_to_file(mainmenu_scene_str)
	elif cliked_credits_button:
		get_tree().change_scene_to_file(credits_scene_str)
		
