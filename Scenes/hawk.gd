extends CharacterBody2D

# Parametry ruchu
@export var radius: float = 100.0  # Promień okręgu
@export var angular_speed: float = 1.0  # Szybkość kątowa w radianach na sekundę
@export var center_position: Vector2 = Vector2(0, 0)  # Punkt środkowy okręgu

var angle: float = 0.0  # Aktualny kąt
var previous_position: Vector2  # Zmienna przechowująca poprzednią pozycję

func _ready() -> void:
	# animacja
	$Area2D/AnimatedSprite2D.play("idle")
	radius = randf_range(2000, 4000)
	angular_speed = randf_range(1.5, 2)
	previous_position = position  # Inicjalizacja poprzedniej pozycji

func _process(delta: float):
	# Aktualizacja kąta w czasie
	angle += angular_speed * delta
	
	# Przeliczenie pozycji na podstawie aktualnego kąta
	var new_position = Vector2(
		center_position.x + radius * cos(angle),
		center_position.y + radius * sin(angle)
	)
	
	# Obliczanie kierunku ruchu
	var direction = new_position - previous_position
	if direction.length() > 0:
		rotation = direction.angle()
	
	# Aktualizacja pozycji
	position = new_position
	previous_position = position  # Zapisanie nowej pozycji jako poprzednia na przyszłość
