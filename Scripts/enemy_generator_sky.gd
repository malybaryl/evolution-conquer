extends Node

var game_menager
var parent

# birds
var Bee_Scene = preload("res://Scenes/bee.tscn")
var Black_bird_Scene = preload("res://Scenes/black_bird.tscn")
var Blue_buterfly_Scene = preload("res://Scenes/blue_butterfly.tscn")
var Purple_buttlefly_Scene = preload("res://Scenes/purple_buttlefly.tscn")

@export var number_of_bees: int = 3
@export var interval_bees: int = 2
@export var interval_black_birds: int = 3
@export var number_of_black_birds: int = 2
@export var number_of_blue_buterfly: int = 3
@export var interval_blue_buterfly: int = 2
@export var number_of_purple_buterfly: int = 3
@export var interval_purple_buterfly: int = 2

# big birds
var Hawk_Scene = preload("res://Scenes/hawk.tscn")
var Flamingo_Scene = preload("res://Scenes/flamingo.tscn")
var Big_White_bird_Scene = preload("res://Scenes/big_white_bird.tscn")

@export var number_of_hawks: int = 1
@export var interval_hawks: int = 1
@export var number_of_flamingos: int = 1
@export var interval_flamingos: int = 1
@export var number_of_big_white_birds: int = 1
@export var interval_big_white_birds: int = 1

# window info
@export var width = 2750
@export var width_negative = -2750
@export var height = 775
@export var height_negative = -2900

func _ready() -> void:
	parent = get_parent()
	
	game_menager = parent.get_node("GameMenagerSky") 
	
	var enemy_number = 0
		
	# BIRDS
	
	# bee
	if number_of_bees - interval_bees < 1:
		enemy_number = randi_range(1, number_of_bees + interval_bees)
	else:
		enemy_number = randi_range(number_of_bees - interval_bees, number_of_bees + interval_bees)
		
	for x in range(enemy_number):
		init_bird("bee")
	
	# black bird	
	if number_of_black_birds - interval_black_birds < 1:
		enemy_number = randi_range(1, number_of_black_birds + interval_black_birds)
	else:
		enemy_number = randi_range(number_of_black_birds - interval_black_birds, number_of_black_birds + interval_black_birds)
		
	for x in range(enemy_number):
		init_bird("black_bird")
		
	# blue buterfly	
	if number_of_blue_buterfly -number_of_blue_buterfly < 1:
		enemy_number = randi_range(1, number_of_blue_buterfly + number_of_blue_buterfly)
	else:
		enemy_number = randi_range(number_of_blue_buterfly -number_of_blue_buterfly, number_of_blue_buterfly +number_of_blue_buterfly)
		
	for x in range(enemy_number):
		init_bird("blue_butterfly")
	
	# purple butterfly	
	if number_of_purple_buterfly -number_of_purple_buterfly < 1:
		enemy_number = randi_range(1, number_of_purple_buterfly +number_of_purple_buterfly)
	else:
		enemy_number = randi_range(number_of_purple_buterfly -number_of_purple_buterfly, number_of_purple_buterfly +number_of_purple_buterfly)
		
	for x in range(enemy_number):
		init_bird("purple_butterfly")
		
	# BIG BIRDS
	
	# hawk	
	if number_of_hawks - number_of_hawks < 1:
		enemy_number = randi_range(1, number_of_hawks +number_of_hawks)
	else:
		enemy_number = randi_range(number_of_hawks -number_of_hawks, number_of_hawks + number_of_hawks)
		
	for x in range(enemy_number):
		init_bird("hawk")
		
	# flamingos
	if number_of_flamingos - number_of_flamingos < 1:
		enemy_number = randi_range(1, number_of_flamingos +number_of_flamingos)
	else:
		enemy_number = randi_range(number_of_flamingos -number_of_flamingos, number_of_flamingos + number_of_flamingos)
		
	for x in range(enemy_number):
		init_bird("flamingo")
		
	# big white bird
	if number_of_big_white_birds - number_of_big_white_birds < 1:
		enemy_number = randi_range(1, number_of_big_white_birds +number_of_big_white_birds)
	else:
		enemy_number = randi_range(number_of_big_white_birds -number_of_big_white_birds, number_of_big_white_birds + number_of_big_white_birds)
		
	for x in range(enemy_number):
		init_bird("big_white_bird")
		 
func init_bird(name):
	var inistance
	var position_x = randi_range(width_negative, width)
	var position_y = randi_range(height_negative, height)
	var scale_ 
	
	if name == "bee":
		inistance = Bee_Scene.instantiate()
		scale_ = randf_range(.2, 1.5)
	elif name == "black_bird":
		inistance = Black_bird_Scene.instantiate()
		scale_ = randf_range(.2, 1.5)
	elif name == "blue_butterfly":
		inistance = Blue_buterfly_Scene.instantiate()	
		scale_ = randf_range(.2, 1.5)
	elif name == "purple_butterfly":
		inistance = Purple_buttlefly_Scene.instantiate()	
		scale_ = randf_range(.2, 1.5)
	elif name == "random_bird":
		var array = ["bee", "black_bird", "blue_butterfly", "purple_butterfly"]
		var enemy = array.pick_random()
		init_bird(enemy)
		return
	
	elif name == "hawk":
		inistance = Hawk_Scene.instantiate()
		scale_ = randf_range(3, 6)
	elif name == "flamingo":
		inistance = Flamingo_Scene.instantiate()
		scale_ = randf_range(3, 6)
	elif name == "big_white_bird":
		inistance = Big_White_bird_Scene.instantiate()
		scale_ = randf_range(3, 6)
	elif name == "random_big_bird":
		var array = ["hawk", "flamingo", "big_white_bird"]
		var enemy = array.pick_random()
		init_bird(enemy)
		return
		
	else:
		print("wrong name in: func init_bird(name): EnemyGeneratorSky")
		
			
	inistance.position.x = position_x
	inistance.position.y = position_y 
	#if game_menager.points < 100:
	inistance.scale.x = scale_
	inistance.scale.y = scale_
	#else:
	#inistance.scale.x = .1
	#inistance.scale.y = .1
	
	add_child(inistance)
	
