extends CharacterBody2D

@export var speed: float = 10 
@export var frequency: float = 1 
@export var amplitude: float = 60  

@export var width = 2750
@export var width_negative = -2750
@export var height = 700
@export var height_negative = -2050

var time: float = 0.0
var direction: Vector2 = Vector2.ZERO
var is_returning_to_bounds: bool = false
\

func _ready():
	amplitude = randf_range(30, 90)
	speed = randf_range(5, 10)
	is_returning_to_bounds = true
	frequency = randf_range(.5, 1)
	$Area2D/AnimatedSprite2D.play("idle")
	



func _process(delta: float):
	print("ray position: ", position)
	if not is_returning_to_bounds:
		if true:
			time += delta
			var t = time * frequency
			
			
			var x = amplitude * sin(t)
			var y = amplitude * sin(t) * cos(t)

			var new_position = position + Vector2(x, y) * delta * speed
			var movement_vector = new_position - position
			
			
			position = new_position
			
		
			direction = movement_vector.normalized()
			
			
			rotation = direction.angle()
	else:
		direction = Vector2.ZERO
		
		if position.x < width_negative:
			position.x += 1 * speed * 25 * delta
			direction.x = 1
		elif position.x > width:
			position.x -= 1 * speed * 25 * delta
			direction.x = -1
			
		if position.y < height_negative:
			position.y += 1 * speed * 25 * delta
			direction.y = 1
		elif position.y > height:
			position.y -= 1 * speed * 25 * delta
			direction.y = -1
		
	
		self.position = position
	

	if direction.length() > 0:
		rotation = direction.angle()		

		if width_negative <= position.x and position.x <= width and height_negative <= position.y and position.y <= height:
			
			is_returning_to_bounds = false
