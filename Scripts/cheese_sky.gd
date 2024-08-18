extends Node

var Cheese_Scene = preload("res://Scenes/cheese.tscn")
var game_menager

@export var number_of_cheese: int
@export var interval: int
@export var width = 2750
@export var width_negative = -2750
@export var height = 700
@export var height_negative = -450

var change_height = true

func _ready() -> void:
	game_menager = get_node("/root/MainScene/GameMenager")
	
	var cheese_number = 0
		
	if number_of_cheese - interval < 1:
		cheese_number = randi_range(1, number_of_cheese + interval)
	else:
		cheese_number = randi_range(number_of_cheese - interval, number_of_cheese + interval)
		
	for x in range(cheese_number):
		init_cheese()
		 
func init_cheese():
	var position_x = randi_range(width_negative, width)
	var position_y = randi_range(height_negative, height)
	var inistance = Cheese_Scene.instantiate()
	inistance.position.x = position_x
	inistance.position.y = position_y 
	add_child(inistance)
	
	if game_menager.points > 99:
		height_negative = -2050
	
	
