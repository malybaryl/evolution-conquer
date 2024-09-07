extends CharacterBody2D


@export var amplitude: float = 2000.0  
@export var speed: float = 2.0  

var original_position: Vector2
var previous_position: Vector2
var time_passed: float = 0.0 

func _ready():
	$Area2D/AnimatedSprite2D.play("idle")
	amplitude = randf_range(700.0, 1500)
	speed = randf_range(.2, .5)
	original_position = position
	previous_position = position

func _process(delta: float):

	time_passed += delta

	position.x = original_position.x + amplitude * sin(speed * time_passed)
	
	var direction = position - previous_position
	if direction.length() > 0:  
		rotation = direction.angle()

	previous_position = position  
