extends Node

var points = 0

var parent
var player
var cursor_texture
var camera
var enemy_generator

var earth
var moon
var mars
var end_game = false

var planets_to_destroy = 3

var end_scene = "res://Scenes/end_screen.tscn"

func _ready() -> void:
	parent = get_parent()
	var music = parent.get_node("Music")
	music.volume_db = (Global.float_to_db(Global.MUSIC))
	player = parent.get_node("Player") 
	camera = player.get_node("Area2D/Camera2DSpace") as Camera2D
	camera.make_current()
	enemy_generator = parent.get_node("EnemiesGeneratorSpace") 
		
	# coursor handling
	cursor_texture = load("res://Assets/UI/Coursor/png/coursor.png")
	Input.set_custom_mouse_cursor(cursor_texture)
	
	# animations
	var bg_animation = parent.get_node("Transition")
	bg_animation.play("bg transition")
	
func _process(delta: float) -> void:
	earth = parent.get_node("Earth")
	moon = parent.get_node("Moon")
	mars = parent.get_node("Mars")
	
	if planets_to_destroy < 1:
		end_game = true
		var bg_animation = parent.get_node("Transition")
		bg_animation.play_backwards("bg transition")

func add_points(number_of_point):
	if number_of_point != null:
		points += number_of_point
		player.scale.x += (number_of_point * .025)
		player.scale.y += (number_of_point * .025)
	else:
		return
	print("number of points: ", points, " scale: ", player.scale.x)
	
	


func _on_transition_animation_finished(anim_name: StringName) -> void:
	if end_game:
		get_tree().change_scene_to_file(end_scene)
