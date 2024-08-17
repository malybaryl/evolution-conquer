extends Node2D

var speed = 200  # Szybkość poruszania się postaci

var game_menager 
var cheese_menager
var enemies_generator

func _ready():
	$Area2D/AnimatedSprite2D.play("idle")
	game_menager = get_node("/root/MainScene/GameMenager")
	cheese_menager = get_node("/root/MainScene/CheeseMenager")
	enemies_generator = get_node("/root/MainScene/EnemiesGenerator")
	


func _process(delta):
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	var distance_to_mouse = global_position.distance_to(mouse_position)
	
	if distance_to_mouse > 1:  # Dystans, przy którym postać zaczyna się poruszać
		global_position += direction * speed * delta
	
	# Obracanie postaci w kierunku kursora
	rotation = (mouse_position - global_position).angle()

func cheese_entered(area: Area2D):
	game_menager.add_points(1)
	cheese_menager.init_cheese()
	area.queue_free()
	
func enemy_entered(area: Area2D):
	# enemy is bigger than player
	if area.scale.x > scale.x:
		queue_free()
	# player is bigger than enemy
	elif area.scale.x < scale.x:
		game_menager.add_points(area.scale.x * 5)
		enemies_generator.init_cells("random")
		area.queue_free()
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("object"):
		cheese_entered(area)
	elif area.is_in_group("enemy"):
		enemy_entered(area)
	
