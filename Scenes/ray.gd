extends CharacterBody2D

@export var speed: float = 10  # Szybkość ruchu przeciwnika
@export var frequency: float = 1 # Częstotliwość sinusoidy
@export var amplitude: float = 60  # Amplituda sinusoidy

var time: float = 0.0
var direction: Vector2 = Vector2.ZERO

func _ready():
	
	speed = randf_range(5, 10)
	# Rozpoczęcie animacji
	$Area2D/AnimatedSprite2D.play("idle")

func _process(delta: float):
	time += delta
	var t = time * frequency
	
	# Parametryczne równanie ósemki
	var x = amplitude * sin(t)
	var y = amplitude * sin(t) * cos(t)

	var new_position = position + Vector2(x, y) * delta * speed
	var movement_vector = new_position - position
	
	# Aktualizacja pozycji
	position = new_position
	
	# Aktualizacja kierunku ruchu
	direction = movement_vector.normalized()
	
	# Aktualizacja rotacji
	rotation = direction.angle()
