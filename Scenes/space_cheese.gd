extends Node2D

var direction : int
@export var speed : float = 50
var smooth 

@export var width : float = 3000
@export var width_negative : float = -3000
@export var height : float = 2000
@export var height_negative : float = -2000

func _ready() -> void:
	direction = randi_range(0,3)
	smooth = speed * 2
	
func _process(delta: float) -> void:
	if direction == 0: 								# up
		position.y -= speed * delta
		if position.y < height_negative - smooth:
			position.y = height + smooth
	elif direction == 1: 							# down
		position.y += speed * delta
		if position.y > height + smooth:
			position.y = height_negative - smooth
	elif direction == 2: 							# right
		position.x += speed * delta
		if position.x > width + smooth:
			position.x = width_negative - smooth
	else: 											# left
		position.x -= speed * delta
		if position.x < width_negative - smooth:
			position.x = width + smooth
		
	
