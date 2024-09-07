extends Node

@export var number_of_comets = 3
@export var number_of_comets_interval = 1
@export var min_scale = 0.5
@export var max_scale = 1.5
@export var min_speed = 200
@export var max_speed = 800

var arrays_names = ["down_points", "top_points", "left_points", "right_points"]
var down_points 
var top_points 
var left_points 
var right_points 

var parent
var timer

@onready var comet = preload("res://Scenes/purple_comet.tscn")

func _ready() -> void:
	parent = get_parent()
	timer = get_node("Timer")
	
	
	down_points = [
		get_node("SpawnPoints/Point").position,
		get_node("SpawnPoints/Point2").position,
		get_node("SpawnPoints/Point3").position,
		get_node("SpawnPoints/Point4").position,
		get_node("SpawnPoints/Point5").position
	]
	
	top_points = [
		get_node("SpawnPoints/Point6").position,
		get_node("SpawnPoints/Point7").position,
		get_node("SpawnPoints/Point8").position,
		get_node("SpawnPoints/Point9").position,
		get_node("SpawnPoints/Point10").position,
		get_node("SpawnPoints/Point11").position
	]
	
	left_points = [
		get_node("SpawnPoints/Point12").position,
		get_node("SpawnPoints/Point13").position
	]
	
	right_points = [
		get_node("SpawnPoints/Point14").position,
		get_node("SpawnPoints/Point15").position
	]
	
	timer.start()

func spawn_comet():
	var array = arrays_names.pick_random()
	
	var spawn_point
	var destiny

	if array == "down_points":
		spawn_point = down_points.pick_random()
		destiny = top_points.pick_random()
	elif array == "top_points":
		spawn_point = top_points.pick_random()
		destiny = down_points.pick_random()
	elif array == "left_points":
		spawn_point = left_points.pick_random()
		destiny = right_points.pick_random()
	elif array == "right_points":
		spawn_point = right_points.pick_random()
		destiny = left_points.pick_random()
	else:
		return    
	
	var speed = randf_range(min_speed, max_speed)
	var scale = randf_range(min_scale, max_scale)
	
	var init = comet.instantiate()
	init.destiny = destiny
	init.position = spawn_point
	init.speed = speed
	init.scale.x = scale
	init.scale.y = scale
	
	parent.add_child(init)

func _on_timer_timeout() -> void:
	spawn_comet()
	timer.start()
