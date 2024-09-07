extends CharacterBody2D

@export var center: Vector2 = Vector2(0, 0)
@export var radius: float = 1000
@export var speed: float = 2
var angle: float = 0.0
var animator : AnimationPlayer
var parent
var earth

func  _ready() -> void:
	animator = $Area2D/AnimationPlayer
	animator.play("rotate_moon")
	parent = get_parent()
	earth = parent.get_node("Earth")
	if earth:
		center = earth.position
	
func _process(delta: float) -> void:
	if earth:
		center = earth.position
		angle += speed * delta  
		var x = center.x + radius * cos(angle)
		var y = center.y + radius * sin(angle)
		position = Vector2(x, y)
	





	
