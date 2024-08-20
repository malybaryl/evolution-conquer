extends CharacterBody2D

# Parametry ruchu
@export var amplitude: float = 2000.0  # Maksymalny zakres ruchu w pikselach
@export var speed: float = 2.0  # Szybkość ruchu

var original_position: Vector2
var previous_position: Vector2
var time_passed: float = 0.0  # Akumulowany czas gry

func _ready():
	# animacja
	$Area2D/AnimatedSprite2D.play("idle")
	# reszta
	amplitude = randf_range(700.0, 1500)
	speed = randf_range(.2, .5)
	original_position = position
	previous_position = position

func _process(delta: float):

	# Akumulowanie czasu gry
	time_passed += delta

	# Obliczanie nowej pozycji na podstawie funkcji sinusoidalnej
	position.x = original_position.x + amplitude * sin(speed * time_passed)
	
	# Obliczanie kierunku ruchu
	var direction = position - previous_position
	if direction.length() > 0:  # Sprawdzamy, czy obiekt się poruszył
		rotation = direction.angle()

	previous_position = position  # Aktualizacja poprzedniej pozycji
