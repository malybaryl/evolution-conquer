extends Node2D

var speed = 200  # Szybkość poruszania się postaci

func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	var direction = (mouse_position - position).normalized()
	position += direction * speed * delta
