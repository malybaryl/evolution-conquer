extends Node

var points = 0
var parent

var player
var cursor_texture
var camera
var camera_to_transform :Camera2D
var enemy_generator

var space_level_str = "res://Scenes/space_level.tscn"

var fish_level = true

@export var sky_level = false

func _ready() -> void:
	parent = get_parent()
	var music = parent.get_node("Music")
	music.volume_db = (Global.float_to_db(Global.MUSIC))
	if sky_level:
		player = parent.get_node("Player") 
		camera = player.get_node("Area2D/Camera2D") as Camera2D
		camera_to_transform = player.get_node("Area2D/Camera2DSky2") as Camera2D
		enemy_generator = parent.get_node("EnemiesGenerator")
		
		# coursor handling
		cursor_texture = load("res://Assets/UI/Coursor/png/coursor.png")
		Input.set_custom_mouse_cursor(cursor_texture)
		
		if not Global.sky_level_completed:
			Global.sky_level_completed = true
			
		var start_transition = parent.get_node("Transition")
		start_transition.play("start_transition")
	

func add_points(number_of_point):
	if number_of_point != null:
		points += number_of_point
		player.scale.x += (number_of_point * .025)
		player.scale.y += (number_of_point * .025)
	else:
		return
	print("number of points: ", points)
	
	
	if points > 55 and fish_level:
		# TODO add invicible time
		tranform_sky_level_camera()
		fish_level = false
	
	if points > 399:
		parent.get_tree().change_scene_to_file(space_level_str)

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
	
	print("fish level")
	
func tranform_sky_level_camera():
	camera_to_transform.make_current()
	
	
	
