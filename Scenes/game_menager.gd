extends Node

var points = 0

var parent
var player
var cursor_texture
var camera
var enemy_generator
@export var reload = false

var fish_level = true

var sky_level_str = "res://Scenes/sky_level.tscn"
var sea_music = preload("res://Scenes/music_sea.tscn")

func _ready() -> void:
	parent = get_parent()
	player = parent.get_node("Player") 	
	camera = player.get_node("Area2D/Camera2D") as Camera2D	
	enemy_generator = parent.get_node("EnemiesGenerator") 
	
	# coursor handling
	cursor_texture = load("res://Assets/UI/Coursor/png/coursor.png")
	Input.set_custom_mouse_cursor(cursor_texture)
	

func add_points(number_of_point):
	if number_of_point != null:
		points += number_of_point
		player.scale.x += (number_of_point * .025)
		player.scale.y += (number_of_point * .025)
	else:
		return
	print("number of points: ", points)
	
	if points > 99 and fish_level == true:
		transform_to_fish_level()
		fish_level = false
	if points > 299:
		parent.get_tree().change_scene_to_file(sky_level_str)

	
func transform_to_fish_level():
	camera.limit_top = -2050
	camera.zoom = Vector2(.5, .5)
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.scale.x = .3
		enemy.scale.y = .3
	var player_animator = player.get_node("Area2D/AnimatedSprite2D")
	player_animator.play("idle_fish")
	player.scale.x = .7
	player.scale.y = .7
	player.speed = 400
	
	enemy_generator.init_all_fish()
	
	# music
	var music = parent.get_node("Music")
	music.queue_free()
	var init = sea_music.instantiate()
	parent.add_child(init)
	
	print("fish level")
	
	
