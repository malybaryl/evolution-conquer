extends CharacterBody2D  # Dla Godot 4.0

# Definiujemy prędkość ruchu
var speed = 100
# Czas zmiany kierunku
var change_direction_time = 2.0
# Zmienna przechowująca czas do zmiany kierunku
var time_left_to_change = 0.0
# Aktualny kierunek ruchu
var direction = Vector2()

@export var width = 2750
@export var width_negative = -2750
@export var height = 700
@export var height_negative = -450

func _ready():
	# animacja
	$Area2D/AnimatedSprite2D.play("idle")
	# Ustawienie losowego kierunku na start
	change_direction()
	# Ustawienie pierwszej zmiany kierunku po upływie change_direction_time
	time_left_to_change = change_direction_time

func _process(delta):
	# Odliczanie czasu do zmiany kierunku
	time_left_to_change -= delta
	if time_left_to_change <= 0:
		change_direction()
		time_left_to_change = change_direction_time
	
	# Sprawdzenie krawędzi mapy i zawracanie
	if position.x > width:
		direction = Vector2(-1, 0)
	elif position.x < width_negative:
		direction = Vector2(1, 0)    
	elif position.y > height:
		direction = Vector2(0, -1)
	elif position.y < height_negative:
		direction = Vector2(0, 1)
		
	# Aktualizacja prędkości na podstawie kierunku
	velocity = direction * speed
	
	# Poruszanie przeciwnikiem
	move_and_slide()

	# Obracanie przeciwnika w kierunku ruchu
	if direction != Vector2():
		rotation = direction.angle()

func change_direction():
	# Losowanie nowego kierunku
	if width_negative < position.x and position.x < width and height_negative < position.y and position.y < height:
		var random_dir = randi() % 4
		match random_dir:
			0:
				direction = Vector2(1, 0)  # Prawo
			1:
				direction = Vector2(-1, 0) # Lewo
			2:
				direction = Vector2(0, 1)  # Dół
			3:
				direction = Vector2(0, -1) # Góra
