extends Node

var Cell_red_Scene = preload("res://Scenes/cell_red.tscn")
var Cell_yellow_Scene = preload("res://Scenes/cell_yellow.tscn")
var Cell_purple_Scene = preload("res://Scenes/cell_purple.tscn")
var Cell_blue_Scene = preload("res://Scenes/cell_blue.tscn")

@export var number_of_red_cells: int
@export var interval_red_cells: int
@export var number_of_yellow_cells: int
@export var interval_yellow_cells: int
@export var number_of_purple_cells: int
@export var interval_purple_cells: int
@export var number_of_blue_cells: int
@export var interval_blue_cells: int

@export var width = 2750
@export var width_negative = -2750
@export var height = 700
@export var height_negative = -450

func _ready() -> void:
	var cells_number = 0
		
	if number_of_red_cells - interval_red_cells < 1:
		cells_number = randi_range(1, number_of_red_cells + interval_red_cells)
	else:
		cells_number = randi_range(number_of_red_cells - interval_red_cells, number_of_red_cells + interval_red_cells)
		
	for x in range(cells_number):
		init_cells("red")
		
	if number_of_yellow_cells - interval_yellow_cells < 1:
		cells_number = randi_range(1, number_of_yellow_cells + interval_yellow_cells)
	else:
		cells_number = randi_range(number_of_yellow_cells - interval_yellow_cells, number_of_yellow_cells + interval_yellow_cells)
		
	for x in range(cells_number):
		init_cells("yellow")
		
	if number_of_purple_cells - interval_purple_cells < 1:
		cells_number = randi_range(1, number_of_purple_cells + interval_purple_cells)
	else:
		cells_number = randi_range(number_of_purple_cells - interval_purple_cells, number_of_purple_cells + interval_purple_cells)
		
	for x in range(cells_number):
		init_cells("purple")
		
	if number_of_blue_cells - interval_blue_cells < 1:
		cells_number = randi_range(1, number_of_blue_cells + interval_blue_cells)
	else:
		cells_number = randi_range(number_of_blue_cells - interval_blue_cells, number_of_blue_cells + interval_blue_cells)
		
	for x in range(cells_number):
		init_cells("blue")
		 
func init_cells(name):
	var inistance
	var position_x = randi_range(width_negative, width)
	var position_y = randi_range(height_negative, height)
	var cell_scale = randf_range(.2, 2)
	
	if name == "red":
		inistance = Cell_red_Scene.instantiate()
	elif name == "yellow":
		inistance = Cell_yellow_Scene.instantiate()
	elif name == "purple":
		inistance = Cell_purple_Scene.instantiate()	
	elif name == "blue":
		inistance = Cell_blue_Scene.instantiate()	
	else:
		var cell_array = ["red", "yellow", "purple", "blue"]
		var cell = cell_array.pick_random()
		init_cells(cell)
		return
			
	inistance.position.x = position_x
	inistance.position.y = position_y 
	inistance.scale.x = cell_scale
	inistance.scale.y = cell_scale
	
	add_child(inistance)
	
	
