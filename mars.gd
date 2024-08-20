extends CharacterBody2D

@export var speed: float = 1000  # Prędkość ruchu

var animator: AnimationPlayer
var points: Array = []
var current_point_index: int = 0
var destiny: Vector2

func _ready() -> void:
	animator = $Area2D/AnimationPlayer
	animator.play("rotate_mars")
	
	# Pobierz punkty
	points = [
		get_node('Points/Point1').position,
		get_node('Points/Point2').position,
		get_node('Points/Point3').position,
		get_node('Points/Point4').position,
		get_node('Points/Point5').position,
		get_node('Points/Point6').position,
		get_node('Points/Point7').position,
		get_node('Points/Point8').position,
		get_node('Points/Point9').position,
		get_node('Points/Point10').position,
		get_node('Points/Point11').position,
		get_node('Points/Point12').position,
		get_node('Points/Point13').position,
		get_node('Points/Point14').position,
		get_node('Points/Point15').position,	
	]

	position = points[0]  # Ustaw początkową pozycję na pierwszy punkt
	destiny = points[1]  # Ustaw pierwszy cel na drugi punkt
	
func _process(delta: float) -> void:
	move_towards_destiny(delta)
	rotate_towards_destiny()

func move_towards_destiny(delta: float) -> void:
	var direction = (destiny - position).normalized()
	if position.distance_to(destiny) < 10:  # Zmienna 10 może być dostosowana
		current_point_index = (current_point_index + 1) % points.size()
		destiny = points[current_point_index]

	# Oblicz nowe przemieszczenie
	var displacement = direction * speed * delta
	position += displacement
	

func rotate_towards_destiny() -> void:
	look_at(destiny)
