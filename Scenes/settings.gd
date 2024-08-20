extends Control

var mainmenu_scene_str = "res://Scenes/main_menu.tscn"
var credits_scene_str = "res://Scenes/control.tscn"
var music
var sfx

func _ready() -> void:
	var bg_anim = get_node("CanvasLayer/Background_space/AnimationPlayer")
	bg_anim.play("bg moving")
	var music = get_node("Music")
	if music:
		music.volume_db = (Global.float_to_db(Global.MUSIC))
	var sfx = get_node("SFX")
	if sfx:
		sfx.volume_db = (Global.float_to_db(Global.SFX))


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(mainmenu_scene_str)


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file(credits_scene_str)


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
