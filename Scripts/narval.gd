extends CharacterBody2D


var speed = 500

var start_position: Vector2
var direction: Vector2


var moving_to_target = true

func _ready():

	start_position = global_position
	var speed = randf_range(400, 800)
	

	$Area2D/AnimatedSprite2D.play("idle")

func _process(delta):

	var target_position = direction if moving_to_target else start_position
	var direction_vector = (target_position - global_position).normalized()
	

	velocity = direction_vector * speed
	

	move_and_slide()
	

	var angle_to_target = direction_vector.angle()
	rotation = angle_to_target
	
	
	if global_position.distance_to(target_position) < 10:
		moving_to_target = not moving_to_target
		
