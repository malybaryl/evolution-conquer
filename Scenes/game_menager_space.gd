extends Node

var points = 0

var parent
var player
var cursor_texture
var camera
var enemy_generator

func _ready() -> void:
	parent = get_parent()
	player = parent.get_node("Player") 
	camera = player.get_node("Area2D/Camera2DSpace") as Camera2D
	camera.make_current()
	enemy_generator = parent.get_node("EnemiesGeneratorSpace") 
		
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
	print("number of points: ", points, " scale: ", player.scale.x)
	
	
