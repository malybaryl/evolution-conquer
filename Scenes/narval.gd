extends CharacterBody2D

# Definiujemy prędkość ruchu
var speed = 500

# Punkt docelowy i punkt początkowy
var start_position: Vector2
var direction: Vector2

# Stan, czy przeciwnik jest w drodze do punktu docelowego
var moving_to_target = true

func _ready():
	# Ustawiamy punkt początkowy
	start_position = global_position
	var speed = randf_range(400, 800)
	
	# Rozpoczęcie animacji
	$Area2D/AnimatedSprite2D.play("idle")

func _process(delta):
	# Ustalanie wektora ruchu w zależności od aktualnego stanu
	var target_position = direction if moving_to_target else start_position
	var direction_vector = (target_position - global_position).normalized()
	
	# Aktualizacja prędkości na podstawie kierunku
	velocity = direction_vector * speed
	
	# Poruszanie przeciwnikiem
	move_and_slide()
	
	# Obliczanie kąta obrotu
	var angle_to_target = direction_vector.angle()
	rotation = angle_to_target
	
	# Sprawdzenie, czy przeciwnik dotarł do celu
	if global_position.distance_to(target_position) < 10:
		moving_to_target = not moving_to_target
		
