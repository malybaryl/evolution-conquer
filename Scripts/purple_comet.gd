extends CharacterBody2D

var animator : AnimationPlayer
var destiny: Vector2
var speed: float

func _ready() -> void:
	animator = $Area2D/AnimationPlayer
	animator.play("rotate_comet")
	
func _process(delta: float) -> void:
	move_towards_destiny(delta)
	rotate_towards_destiny()

func move_towards_destiny(delta: float) -> void:
	var direction = (destiny - position).normalized()
	position += direction * speed * delta
	
	if position.distance_to(destiny) < 10:
		queue_free()

func rotate_towards_destiny() -> void:
	var direction = (destiny - position).normalized()
	rotation = direction.angle()
