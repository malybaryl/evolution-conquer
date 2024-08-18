extends Node2D


var speed = 200  # Szybkość poruszania się postaci

var game_menager 
var cheese_menager
var enemies_generator
var parent
var player

var game_over_scene_str = "res://Scenes/lose_scene.tscn"

@export var sky_level = false
@export var space_level = false

var audio_can_be_played = true
var audio

func _ready():
	
	parent = get_parent()
	audio = get_node("Area2D/AudioEating")
	
	if not sky_level and not space_level:
		game_menager = parent.get_node("GameMenager")
		cheese_menager = parent.get_node("CheeseMenager")
		enemies_generator = parent.get_node("EnemiesGenerator")
		$Area2D/AnimatedSprite2D.play("idle")
	elif space_level: 
		game_menager = parent.get_node("GameMenagerSpace")
		cheese_menager = parent.get_node("CheeseMenager")
		enemies_generator = parent.get_node("EnemyGeneratorSpace")
		player = parent.get_node("Player")
		var camera_space = player.get_node("Area2D/Camera2DSpace") as Camera2D
		camera_space.make_current()
		var player_animator = player.get_node("Area2D/AnimatedSprite2D")
		player_animator.play("idle_comet")
		var player_rotator = player.get_node("Area2D/AnimatedSprite2D/AnimationPlayer")
		player_rotator.play("rotating")
	else:
		player = parent.get_node("Player")
		game_menager = parent.get_node("GameMenagerSky")
		cheese_menager = parent.get_node("CheeseMenager")
		enemies_generator = parent.get_node("EnemyGeneratorSky")
		var player_animator = player.get_node("Area2D/AnimatedSprite2D")
		player_animator.play("idle_bird")
		var camera_sky = player.get_node("Area2D/Camera2DSky1")
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
	play_audio()
	
func game_over():
	get_parent().get_tree().change_scene_to_file(game_over_scene_str)
	
func enemy_entered(area: Area2D):
	var enemy = area.get_parent()
	var enemy_scale = enemy.scale.x
	print(enemy_scale, scale)
	if area.is_in_group("cell"):
		if game_menager != null:
			if game_menager.points < 100:
				# enemy is bigger than player
				if enemy_scale > scale.x:
					queue_free()
					game_over()
				# player is bigger than enemy
				elif enemy_scale < scale.x:
					game_menager.add_points(enemy_scale * 10)
					enemies_generator.init_cells("random")
					area.queue_free()
					play_audio()
			else:
				game_menager.add_points(1.5)
				enemies_generator.init_cells("random")
				area.queue_free()
				play_audio()
	elif area.is_in_group("fish"):
		#if game_menager.points >= 100:
			# enemy is bigger than player
		if enemy_scale > scale.x:
			queue_free()
			game_over()
			# player is bigger than enemy
		elif enemy_scale < scale.x:
			game_menager.add_points(enemy_scale * 10)
			enemies_generator.init_fish("random")
			area.queue_free()
			play_audio()
			
	elif area.is_in_group("bird"):
		# enemy is bigger than player
		if enemy_scale > scale.x:
			queue_free()
			game_over()
		## player is bigger than enemy
		elif enemy_scale < scale.x:
			game_menager.add_points(area.scale.x * 15)
			enemies_generator.init_bird("random_bird")
			area.queue_free()
			play_audio()
		
		

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("object"):
		cheese_entered(area)
	elif area.is_in_group("enemy"):
		enemy_entered(area)
	

func play_audio():
	if audio_can_be_played:
		audio.play()
		audio_can_be_played = false

func _on_audio_eating_finished() -> void:
	audio_can_be_played = true
