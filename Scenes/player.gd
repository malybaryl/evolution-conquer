extends Node2D

var speed = 200  # Szybkość poruszania się postaci

var game_menager 
var cheese_menager
var enemies_generator


@export var sky_level = false
@export var space_level = false


func _ready():
	
	
	if not sky_level and not space_level:
		game_menager = get_node("/root/MainScene/GameMenager")
		cheese_menager = get_node("/root/MainScene/CheeseMenager")
		enemies_generator = get_node("/root/MainScene/EnemiesGenerator")
		$Area2D/AnimatedSprite2D.play("idle")
	elif space_level: 
		game_menager = get_node("/root/SpaceLevel/GameMenagerSpace")
		cheese_menager = get_node("/root/SpaceLevel/CheeseMenager")
		enemies_generator = get_node("/root/SpaceLevel/EnemiesGenerator")
		var camera_space = $Area2D/Camera2DSpace as Camera2D
		camera_space.make_current()
		$Area2D/AnimatedSprite2D.play("idle_comet")
		$Area2D/AnimatedSprite2D/AnimationPlayer.play("rotating")
	else:
		game_menager = get_node("/root/SkyLevel/GameMenagerSky")
		cheese_menager = get_node("/root/SkyLevel/CheeseMenager")
		enemies_generator = get_node("/root/SkyLevel/EnemyGeneratorSky")
		$Area2D/AnimatedSprite2D.play("idle_bird")
		var camera_sky = $Area2D/Camera2DSky1 as Camera2D
		camera_sky.make_current()
		speed = 800
		scale.x = .5
		scale.y = .5
	
	


func _process(delta):
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	var distance_to_mouse = global_position.distance_to(mouse_position)
	
	if distance_to_mouse > 1:  # Dystans, przy którym postać zaczyna się poruszać
		global_position += direction * speed * delta
	
	# Obracanie postaci w kierunku kursora
	rotation = (mouse_position - global_position).angle()

func cheese_entered(area: Area2D):
	if not sky_level and not space_level:
		if game_menager.points < 100:
			game_menager.add_points(3)
		else:
			game_menager.add_points(1)
	elif sky_level:
		game_menager.add_points(.5)
	else:
		game_menager.add_points(.5)
		speed += 10
	cheese_menager.init_cheese()
	area.queue_free()
	
func enemy_entered(area: Area2D):
	if area.is_in_group("cell"):
		if game_menager.points < 100:
			# enemy is bigger than player
			if area.scale.x > scale.x:
				queue_free()
			# player is bigger than enemy
			elif area.scale.x < scale.x:
				game_menager.add_points(area.scale.x * 10)
				enemies_generator.init_cells("random")
				area.queue_free()
		else:
			game_menager.add_points(1.5)
			enemies_generator.init_cells("random")
			area.queue_free()
	elif area.is_in_group("fish"):
		#if game_menager.points >= 100:
			# enemy is bigger than player
		if area.scale.x > scale.x:
			queue_free()
			# player is bigger than enemy
		elif area.scale.x < scale.x:
			game_menager.add_points(area.scale.x * 10)
			enemies_generator.init_fish("random")
			area.queue_free()
			
	elif area.is_in_group("bird"):
		# enemy is bigger than player
		if area.scale.x > scale.x:
			queue_free()
		# player is bigger than enemy
		elif area.scale.x < scale.x:
			game_menager.add_points(area.scale.x * 15)
			enemies_generator.init_fish("random")
			area.queue_free()
		
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("object"):
		cheese_entered(area)
	elif area.is_in_group("enemy"):
		enemy_entered(area)
	
