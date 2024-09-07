extends Node2D

var speed = 200  # Szybkość poruszania się postaci

var game_menager 
var cheese_menager
var enemies_generator
var parent
var player
var pause_menu_instance 
var timer :Timer

var menu_paused
var particles

var game_over_scene_str = "res://Scenes/lose_scene.tscn"

@export var sky_level = false
@export var space_level = false

var audio_can_be_played = true
var audio

var invicible = true

var paused = false
@onready var pause_menu = preload("res://Scenes/pause_menu.tscn")

# collision shape info
@export var cell_shape = true
@export var fish_shape = false
@export var bird_shape = false
@export var comet_shape = false

var last_direction

var width = 2750
var width_negative = -2750
var height = 700
var height_negative = -450
#@export var exp_height_negative = -2050

func start_invicible():
	invicible = true
	timer.start()
	
func _ready():
	parent = get_parent()
	audio = get_node("Area2D/AudioEating")
	timer = get_node("Timer")
	
	if not sky_level and not space_level:
		game_menager = parent.get_node("GameMenager")
		cheese_menager = parent.get_node("CheeseMenager")
		enemies_generator = parent.get_node("EnemiesGenerator")
		$Area2D/AnimatedSprite2D.play("idle")
		width = 2750
		width_negative = -2750
		height = 700
		height_negative = -450
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
	
	# shape
	var cell_collision = get_node("Area2D/CollisionShape2D") as CollisionShape2D
	var fish_collision = get_node("Area2D/CollisionShape2DFish")
	var fish_collision_2 = get_node("Area2D/CollisionShape2DFish2")
	var bird_collsion_1 = get_node("Area2D/CollisionShape2DBird")
	var bird_collsion_2 = get_node("Area2D/CollisionShape2DBird2")
	var comet_collision = get_node("Area2D/CollisionShape2DComet")
	
	if cell_shape:
		cell_collision.disabled = false
		fish_collision.disabled = true
		fish_collision_2.disabled = true
		bird_collsion_1.disabled = true
		bird_collsion_2.disabled = true
		comet_collision.disabled = true
	elif fish_shape:
		transform_to_fish()
		height_negative = -2050
	elif bird_shape:
		cell_collision.disabled = true
		fish_collision.disabled = true
		fish_collision_2.disabled = true
		bird_collsion_1.disabled = false
		bird_collsion_2.disabled = false
		comet_collision.disabled = true
		height_negative = -2920
	elif comet_shape:
		cell_collision.disabled = true
		fish_collision.disabled = true
		fish_collision_2.disabled = true
		bird_collsion_1.disabled = true
		bird_collsion_2.disabled = true
		comet_collision.disabled = false
		height_negative = -2000
		
	last_direction = (get_global_mouse_position() - global_position).normalized()
	
	# Uruchomienie timera na początku
	timer.start()

func set_height_negative(value: int = -2050):
	height_negative = value

func transform_to_fish():
	var cell_collision = get_node("Area2D/CollisionShape2D") as CollisionShape2D
	var fish_collision = get_node("Area2D/CollisionShape2DFish")
	var fish_collision_2 = get_node("Area2D/CollisionShape2DFish2")
	var bird_collsion_1 = get_node("Area2D/CollisionShape2DBird")
	var bird_collsion_2 = get_node("Area2D/CollisionShape2DBird2")
	var comet_collision = get_node("Area2D/CollisionShape2DComet")
	
	cell_collision.disabled = true
	fish_collision.disabled = false
	fish_collision_2.disabled = false
	bird_collsion_1.disabled = true
	bird_collsion_2.disabled = true
	comet_collision.disabled = true
	
	
func pauseMenu():
	if paused:
		pause_menu_instance.queue_free()
		Engine.time_scale = 1  # Wznów grę
	else:
		pause_menu_instance = pause_menu.instantiate()
		get_tree().root.add_child(pause_menu_instance)
		Engine.time_scale = 0  # Wstrzymaj grę
	
	paused = !paused

func _process(delta):
	if not invicible:
		# pause menu
		if Input.is_action_just_pressed("pause"):
			pauseMenu()
		
		# other stuff
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - global_position).normalized()
		var distance_to_mouse = global_position.distance_to(mouse_position)
		
		if distance_to_mouse > 50:  # Dystans, przy którym postać zaczyna się poruszać
			if global_position.x > width:
				global_position.x += -1 * speed * delta
			elif global_position.x < width_negative:
				global_position.x += 1 * speed * delta
			elif global_position.y > height:
				global_position.y += -1 * speed * delta
			elif global_position.y < height_negative:
				global_position.y += 1 * speed * delta
			else:
				global_position += direction * speed * delta
		
			
			# Ustawienie emisji cząsteczek w przeciwnym kierunku do ruchu
			if particles:             
				# Ustawienie prędkości cząsteczek w przeciwnym kierunku
				particles.emitting = true
				var velocity_dir = -direction * speed * 1000  # Dostosuj mnożnik według potrzeb
				particles.direction = velocity_dir.angle()
				particles.initial_velocity = velocity_dir.length()
		
		# Obracanie postaci w kierunku kursora
		rotation = (mouse_position - global_position).angle()
		

func cheese_entered(area: Area2D):
	if not sky_level and not space_level:
		if game_menager.points < 100:
			game_menager.add_points(3)
		else:
			game_menager.add_points(1)
	elif sky_level:
		game_menager.add_points(1)
	else:
		game_menager.add_points(.8)
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
		var danger = enemy.get_node("Area2D/Danger")
		
		if danger:
			# Sprawdzanie kolizji z CollisionShape2D
			if danger.is_colliding():
				queue_free()
				game_over()
		
		if enemy_scale > scale.x:
			queue_free()
			game_over()
		elif enemy_scale < scale.x:
			game_menager.add_points(enemy_scale * 10)
			enemies_generator.init_fish("random")
			area.queue_free()
			play_audio()
	elif area.is_in_group("bird"):
		if enemy_scale > scale.x:
			queue_free()
			game_over()
		elif enemy_scale <= scale.x:
			game_menager.add_points(area.scale.x * 8 )
			enemies_generator.init_bird("random_bird")
			area.queue_free()
			play_audio()
	elif area.is_in_group("comet"):
		if enemy_scale > scale.x:
			queue_free()
			game_over()
		elif enemy_scale < scale.x:
			game_menager.add_points(area.scale.x * 6)
			area.queue_free()
			play_audio()
			
		if area.is_in_group("bigPlanet"):
			if game_menager.planets_to_destroy:
				game_menager.planets_to_destroy = game_menager.planets_to_destroy - 1
	elif area.is_in_group("danger"):
		if enemy_scale * 3 > scale.x:
			queue_free()
			game_over()
		elif enemy_scale * 3 < scale.x:
			game_menager.add_points(enemy_scale * 15)
			enemies_generator.init_fish("random")
			area.queue_free()
			play_audio()
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if not invicible:
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

func _on_timer_timeout() -> void:
	invicible = false
