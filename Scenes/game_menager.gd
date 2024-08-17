extends Node

var points = 0

var player
var cursor_texture

func _ready() -> void:
	player = get_node("/root/MainScene/Player") 
	
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
