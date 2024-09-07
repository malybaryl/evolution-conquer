extends Node

var parent

var Cheese_Scene = preload("res://Scenes/cheese.tscn")
var Sky_cheese_Scene = preload("res://Scenes/sky_cheese.tscn")
var Space_cheese_Scene = preload("res://Scenes/space_cheese.tscn")
var game_menager
@export var reload = true

@export var number_of_cheese: int
@export var interval: int
@export var width = 2750
@export var width_negative = -2750
@export var height = 700
@export var height_negative = -450

@export var sky_cheese = false
@export var space_cheese = false

var change_height = true

func _ready() -> void:
	parent = get_parent()
	
	var cheese_number = 0
	
	if number_of_cheese - interval < 1:
		cheese_number = randi_range(1, number_of_cheese + interval)
	else:
		cheese_number = randi_range(number_of_cheese - interval, number_of_cheese + interval)
		
	for x in range(cheese_number):
		init_cheese()
	
func _process(delta: float) -> void:
	if reload:
		if sky_cheese:
			game_menager = parent.get_node("GameMenager")
		elif space_cheese:
			game_menager = get_node("/root/SpaceLevel/GameMenagerSpace")
		else:
			game_menager = get_node("/root/MainScene/GameMenager")	
		reload = false 
		
		
func init_cheese():
	var inistance
	var position_x = randi_range(width_negative, width)
	var position_y = randi_range(height_negative, height)
	if not sky_cheese and not space_cheese:
		inistance = Cheese_Scene.instantiate()
	elif sky_cheese:
		inistance = Sky_cheese_Scene.instantiate()
		var animation = inistance.get_node("Area2D/AnimatedSprite2D")
		animation.play("idle")
	else:
		inistance = Space_cheese_Scene.instantiate()
	inistance.position.x = position_x
	inistance.position.y = position_y 
	add_child(inistance)
	
	if not sky_cheese and not space_cheese:
		if game_menager != null:
			if game_menager.points > 99:
				height_negative = -2050
	
	
