extends CharacterBody2D

@export var center: Vector2 = Vector2(0, 0)
@export var radius: float = 2000
@export var speed: float = 1.0
var angle: float = 0.0
var animator : AnimationPlayer

func  _ready() -> void:
	animator = $Area2D/AnimationPlayer
	animator.play("rotate")
	
func _process(delta: float) -> void:
	angle += speed * delta  
	var x = center.x + radius * cos(angle)
	var y = center.y + radius * sin(angle)
	position = Vector2(x, y)
	





	
