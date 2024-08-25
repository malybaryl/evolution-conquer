extends Node

# cells
var Cell_red_Scene = preload("res://Scenes/cell_red.tscn")
var Cell_yellow_Scene = preload("res://Scenes/cell_yellow.tscn")
var Cell_purple_Scene = preload("res://Scenes/cell_purple.tscn")
var Cell_blue_Scene = preload("res://Scenes/cell_blue.tscn")

# fish
var Narval_Scene = preload("res://Scenes/narval.tscn")
var Ray_Scene = preload("res://Scenes/ray.tscn")
var Spiked_fish_Scene = preload("res://Scenes/spiked_fish.tscn")
var Wale_Scene = preload("res://Scenes/wale.tscn")

var game_menager

# cells
@export var number_of_red_cells: int
@export var interval_red_cells: int
@export var interval_yellow_cells: int
@export var number_of_yellow_cells: int
@export var number_of_purple_cells: int
@export var interval_purple_cells: int
@export var number_of_blue_cells: int
@export var interval_blue_cells: int

# fish
@export var number_of_narvals: int
@export var interval_narvals: int
@export var number_of_rays: int
@export var interval_ray: int
@export var number_of_spiked_fish: int
@export var interval_spiked_fish: int
@export var number_of_wale: int
@export var interval_wale: int

# window info
@export var width = 2750
@export var width_negative = -2750
@export var height = 700
@export var height_negative = -450
@export var exp_height_negative = -2050

var parent
var player_mesh = 600
var player

var narval_points

func _ready() -> void:
	parent = get_parent()
	game_menager = parent.get_node("GameMenager") 
	player = parent.get_node("Player")
	
	# narval points
	narval_points = [
		get_node("NarvalPoints/Point1").position,
		get_node("NarvalPoints/Point2").position,
		get_node("NarvalPoints/Point3").position,
		get_node("NarvalPoints/Point4").position,
		get_node("NarvalPoints/Point5").position,
		get_node("NarvalPoints/Point6").position,
		get_node("NarvalPoints/Point7").position,
		get_node("NarvalPoints/Point8").position,
		get_node("NarvalPoints/Point9").position,
		get_node("NarvalPoints/Point10").position,
		get_node("NarvalPoints/Point11").position,
		get_node("NarvalPoints/Point12").position,
		get_node("NarvalPoints/Point13").position,
		get_node("NarvalPoints/Point14").position,
		get_node("NarvalPoints/Point15").position,
		get_node("NarvalPoints/Point16").position,
		get_node("NarvalPoints/Point17").position,
		get_node("NarvalPoints/Point18").position,
		get_node("NarvalPoints/Point19").position,
		get_node("NarvalPoints/Point20").position,
	]
	
	init_all_cells()

func init_all_cells():	
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
		 
func init_cells(name, attempts = 10):
	if attempts <= 0:
		# Maximum attempts reached, place cell at a random position without checking proximity to player
		var inistance
		var position_x = randi_range(width_negative, width)
		var position_y = randi_range(height_negative, height)
		var cell_scale = randf_range(.2, 2)
		
		match name:
			"red":
				inistance = Cell_red_Scene.instantiate()
			"yellow":
				inistance = Cell_yellow_Scene.instantiate()
			"purple":
				inistance = Cell_purple_Scene.instantiate()
			"blue":
				inistance = Cell_blue_Scene.instantiate()
			_:
				inistance = Cell_red_Scene.instantiate()
				
		
		inistance.position.x = position_x
		inistance.position.y = position_y
		
		if game_menager.points < 100:
			inistance.scale.x = cell_scale
			inistance.scale.y = cell_scale
		else:
			inistance.scale.x = .1
			inistance.scale.y = .1
		
		add_child(inistance)
		return

	var position_x = randi_range(width_negative, width)
	var position_y = randi_range(height_negative, height)
	
	if abs(position_x - player.position.x) < player_mesh or abs(position_y - player.position.y) < player_mesh:
		init_cells(name, attempts - 1)
		return

	var inistance
	var cell_scale = randf_range(.2, 2)
	
	match name:
		"red":
			inistance = Cell_red_Scene.instantiate()
		"yellow":
			inistance = Cell_yellow_Scene.instantiate()
		"purple":
			inistance = Cell_purple_Scene.instantiate()
		"blue":
			inistance = Cell_blue_Scene.instantiate()
		_:
			var cell_array = ["red", "yellow", "purple", "blue"]
			var cell = cell_array.pick_random()
			init_cells(name, attempts - 1)
			return
		
	inistance.position.x = position_x
	inistance.position.y = position_y
	if game_menager.points < 100:
		inistance.scale.x = cell_scale
		inistance.scale.y = cell_scale
	else:
		inistance.scale.x = .1
		inistance.scale.y = .1
	add_child(inistance)
	
func init_all_fish():
	var fish_number = 0
		
	if number_of_narvals - interval_narvals < 1:
		fish_number = randi_range(1, number_of_narvals + interval_narvals)
	else:
		fish_number = randi_range(number_of_narvals - interval_narvals, number_of_narvals + interval_narvals)
		
	for x in range(fish_number):
		init_fish("narval")
		
	if number_of_rays - interval_ray < 1:
		fish_number = randi_range(1, number_of_rays + interval_ray)
	else:
		fish_number = randi_range(number_of_rays - interval_ray, number_of_rays + interval_ray)
		
	for x in range(fish_number):
		init_fish("ray")
		
	if number_of_spiked_fish - interval_spiked_fish < 1:
		fish_number = randi_range(1, number_of_spiked_fish + interval_spiked_fish)
	else:
		fish_number = randi_range(number_of_spiked_fish - interval_spiked_fish, number_of_spiked_fish + interval_spiked_fish)
		
	for x in range(fish_number):
		init_fish("spiked_fish")
		
	if number_of_wale - interval_wale < 1:
		fish_number = randi_range(1, number_of_wale + interval_wale)
	else:
		fish_number = randi_range(number_of_wale - interval_wale, number_of_wale + interval_wale)
		
	for x in range(fish_number):
		init_fish("wale")

func init_fish(name):
	var inistance
	var position_x = randi_range(width_negative, width)
	var position_y = randi_range(exp_height_negative, height)
	
	if abs(position_x - player.position.x) < player_mesh:
		init_fish(name)
		return
	if abs(position_y - player.position.y) < player_mesh:
		init_fish(name)
		return
	
	var fish_scale = randf_range(1, 4)
	
	if name == "narval":
		var init_position
		var direction_position
		var going_up
		var index = randi_range(0, narval_points.size() - 1)
		if index % 2 == 0:
			init_position = narval_points[index]
			direction_position = narval_points[index + 1]
			going_up = true
		else:
			init_position = narval_points[index]
			direction_position = narval_points[index - 1]	
			going_up = false
		position_x = init_position[0]
		position_y = init_position[1]
		fish_scale = randf_range(.5, 1.5)
		inistance = Narval_Scene.instantiate()
		inistance.direction = direction_position
	elif name == "ray":
		inistance = Ray_Scene.instantiate()
	elif name == "spiked_fish":
		inistance = Spiked_fish_Scene.instantiate()	
	elif name == "wale":
		inistance = Wale_Scene.instantiate()	
	else:
		var fish_array = ["narval", "ray", "spiked_fish", "wale"]
		var fish = fish_array.pick_random()
		init_fish(fish)
		return
			
	inistance.position.x = position_x
	inistance.position.y = position_y 
	inistance.scale.x = fish_scale
	inistance.scale.y = fish_scale
	
	
	add_child(inistance)


	
