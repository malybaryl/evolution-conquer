extends Node

var points = 0
var parent
var player
var cursor_texture
var camera
var enemy_generator
@export var reload = false
@export var start_with_fish_level = false

var fish_level = true
var next_level = false
var sky_level_str = "res://Scenes/sky_level.tscn"
var sea_music = preload("res://Scenes/music_sea.tscn")
var can_go_to_sky = false
var loading_screen


func _ready() -> void:
	
	parent = get_parent()
	player = parent.get_node("Player") 	
	camera = player.get_node("Area2D/Camera2D") as Camera2D	
	enemy_generator = parent.get_node("EnemiesGenerator") 
	loading_screen = parent.get_node("LoadingScreen")

	
	var music = parent.get_node("Music")
	music.volume_db = (Global.float_to_db(Global.MUSIC))
	
	# coursor handling
	cursor_texture = load("res://Assets/UI/Coursor/png/coursor.png")
	Input.set_custom_mouse_cursor(cursor_texture)
	
	if start_with_fish_level:
		loading_screen.visible = true
		add_points(100)
		next_level = true
	
	var start_transition = parent.get_node("StartTransition")
	start_transition.play("start_transition")
	

func add_points(number_of_point):
	if number_of_point != null:
		points += number_of_point
		player.scale.x += (number_of_point * .025)
		player.scale.y += (number_of_point * .025)
	else:
		return
	print("number of points: ", points)
	
	if points > 99 and fish_level == true:
		if not Global.deep_sea_level_completed:
			Global.deep_sea_level_completed = true
		if not Global.sea_level_completed:
			Global.sea_level_completed = true
		transform_to_fish_level()
		var enemies = get_tree().get_nodes_in_group("cell")
		for enemy in enemies:
			enemy.queue_free()
		fish_level = false
			
	if points > 299:
		
		can_go_to_sky = true
		var start_transition = parent.get_node("StartTransition")
		start_transition.play_backwards("start_transition")
		

	
func transform_to_fish_level():
	next_level = true
	if not start_with_fish_level:
		var start_transition = parent.get_node("StartTransition")
		start_transition.play_backwards("start_transition")
	
	# music
	var music = parent.get_node("Music")
	if music:
		music.queue_free()
	var init = sea_music.instantiate()
	parent.add_child(init)
	
	print("fish level")
	
	


func _on_start_transition_animation_finished(anim_name: StringName) -> void:
	if next_level:
		loading_screen.visible = false
		var player_animator = player.get_node("Area2D/AnimatedSprite2D")
		player_animator.play("idle_fish")
		camera.limit_top = -2050
		camera.zoom = Vector2(.5, .5)
		var enemies = get_tree().get_nodes_in_group("enemy")
		for enemy in enemies:
			enemy.queue_free()
		player.scale.x = .7
		player.scale.y = .7
		player.speed = 400
		player.invicible = true
		player.timer.start()
		enemy_generator.init_all_cells()
		enemy_generator.init_all_fish()
		next_level = false
		
		var start_transition = parent.get_node("StartTransition")
		start_transition.play("start_transition")
		
	if can_go_to_sky:
		parent.get_tree().change_scene_to_file(sky_level_str)
		

		
