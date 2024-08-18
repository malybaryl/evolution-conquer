extends Node2D

var first_level = preload("res://Scenes/main_scene.tscn")
var second_level = preload("res://Scenes/sky_level.tscn")
var third_level = preload("res://Scenes/space_level.tscn")


@export var turn_on_first_level = false
@export var turn_on_second_level = false
@export var turn_on_third_level = false

var can_by_audio_played = true
var button_audio

func _ready() -> void:
	
	# audio
	button_audio = get_node("Button") as AudioStreamPlayer
	
	# animations
	var background_animator = get_node("Background_space/AnimationPlayer")
	background_animator.play("bg moving")
	
	var title_animator = get_node("UI/Title/AnimationPlayer")
	title_animator.play("title_animation")
	
	var green_cell_animator = get_node("Cell_Green")
	green_cell_animator.play("idle")
	
	var earth_animator = get_node("Earth/AnimationPlayer")
	earth_animator.play("earth_menu_animation")
	
	var moon_animator = get_node("Earth/Moon/AnimationPlayer")
	moon_animator.play("moon_menu_animation")
	
	var mars_animator = get_node("Mars/AnimationPlayer")
	mars_animator.play("mars_menu_animation")
	
	var bird_animator = get_node("Bird")
	bird_animator.play("idle_bird")
	
	var bird_moving = bird_animator.get_node("AnimationPlayer")
	bird_moving.play("bird_menu_animation")
	
	var hawk_animator = get_node("Hawk/AnimationPlayer")
	hawk_animator.play("hawk_menu_animation")
	
	var shark_animator = get_node("Shark")
	shark_animator.play("idle_fish")
	
	var shark_moving = shark_animator.get_node("AnimationPlayer")
	shark_moving.play("shark_menu_animation")
	
	var narval_animator = get_node("Narval")
	narval_animator.play("idle")
	
	var narval_moving = narval_animator.get_node("AnimationPlayer")
	narval_moving.play("narval_menu_animation")
	
	var red_cell_animator = get_node("RedCell")
	red_cell_animator.play("idle")
	
	var red_cell_moving = red_cell_animator.get_node("AnimationPlayer")
	red_cell_moving.play("red_cell_menu_animation")
	
func _process(delta: float) -> void:
	if turn_on_first_level:
		if first_level:
			
			print("first_level loaded")
			
			var instance = first_level.instantiate()
			if instance:
				print("Instance created")
				get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
				add_child(instance)
				print("Instance added to scene tree")
			else:
				print("Failed to create instance")
		else:
			print("Failed to preload first_level")
		turn_on_first_level = false
			
	if turn_on_second_level:
		if second_level:
			print("second_level loaded")
			var instance = second_level.instantiate()
			if instance:
				print("Instance created")
				add_child(instance)
				print("Instance added to scene tree")
			else:
				print("Failed to create instance")
		else:
			print("Failed to preload second_level")
		turn_on_second_level = false
			
	if turn_on_third_level:
		if third_level:
			print("second_level loaded")
			var instance = third_level.instantiate()
			if instance:
				print("Instance created")
				add_child(instance)
				print("Instance added to scene tree")
			else:
				print("Failed to create instance")
		else:
			print("Failed to preload third_level")
		turn_on_third_level = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_start_button_pressed() -> void:
	turn_on_first_level = true


func _on_button_finished() -> void: # chossing music
	can_by_audio_played = true

func _on_start_button_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_start_button_mouse_exited() -> void:
	can_by_audio_played = true


func _on_settings_button_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_settings_button_mouse_exited() -> void:
	can_by_audio_played = true


func _on_quit_button_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_quit_button_mouse_exited() -> void:
	can_by_audio_played = true
