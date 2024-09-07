extends CharacterBody2D  

var speed = 100
var direction = Vector2()

@export var width = 2750
@export var width_negative = -2750
@export var height = 700
@export var height_negative = -2050

func _ready():
	speed = randf_range(200, 350)
	$Area2D/AnimatedSprite2D.play("idle")
	change_direction()

	

func _process(delta):
	
	if position.x > width:
		direction = Vector2(-1, 0)
	elif position.x < width_negative:
		direction = Vector2(1, 0)    
	elif position.y > height:
		direction = Vector2(0, -1)
	elif position.y < height_negative:
		direction = Vector2(0, 1)
		
	velocity = direction * speed
	
	move_and_slide()

	if direction != Vector2():
		rotation = direction.angle()

func change_direction():
	if width_negative < position.x and position.x < width and height_negative < position.y and position.y < height:
		var random_dir = randi() % 4
		match random_dir:
			0:
				direction = Vector2(1, 0) 
			1:
				direction = Vector2(-1, 0) 
			2:
				direction = Vector2(0, 1)  
			3:
				direction = Vector2(0, -1)
