extends CharacterBody2D

@export var radius: float = 100.0  
@export var angular_speed: float = 1.0  
@export var center_position: Vector2 = Vector2(0, 0)  

var angle: float = 0.0  
var previous_position: Vector2  

func _ready() -> void:

	$Area2D/AnimatedSprite2D.play("idle")
	radius = randf_range(2000, 4000)
	angular_speed = randf_range(1.5, 2)
	previous_position = position 

func _process(delta: float):
	
	angle += angular_speed * delta
	

	var new_position = Vector2(
		center_position.x + radius * cos(angle),
		center_position.y + radius * sin(angle)
	)
	

	var direction = new_position - previous_position
	if direction.length() > 0:
		rotation = direction.angle()
	

	position = new_position
	previous_position = position 
