extends Control

@export var turn_on_first_level = false

var first_level = "res://Scenes/main_scene.tscn"

var	cliked_start_button = false
var cliked_quit_button = false
var cliked_settings_button = false

var can_by_audio_played = true
var button_audio
var settings_scene_str = "res://Scenes/settings.tscn"
var choose_level_scene = "res://Scenes/choose_level.tscn"


func _ready() -> void:
	# display
	var resolution = Global.resolution
	var fullscreen = Global.fullscreen
	
	if resolution and resolution[0] > 100 and resolution[1] > 100:
		DisplayServer.window_set_size(Vector2i(resolution[0],resolution[1]))
	else:
		DisplayServer.window_set_size(Vector2i(1280,720))
	
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
	# audio
	button_audio = get_node("Button") as AudioStreamPlayer
	button_audio.volume_db = (Global.float_to_db(Global.SFX))
	
	var music = get_node("Music")
	music.volume_db = (Global.float_to_db(Global.MUSIC))
	
	
	# animations
	var background_animator = get_node("Background_space/AnimationPlayer")
	background_animator.play("bg moving")
	
	var title_animator = get_node("UI/Title/AnimationPlayer")
	title_animator.play("title_animation")
	
	var green_cell_animator = get_node("Sprites/Cell_Green")
	green_cell_animator.play("idle")
	
	var earth_animator = get_node("Sprites/Earth/AnimationPlayer")
	earth_animator.play("earth_menu_animation")
	
	var moon_animator = get_node("Sprites/Earth/Moon/AnimationPlayer")
	moon_animator.play("moon_menu_animation")
	
	var mars_animator = get_node("Sprites/Mars/AnimationPlayer")
	mars_animator.play("mars_menu_animation")
	
	var bird_animator = get_node("Sprites/Bird")
	bird_animator.play("idle_bird")
	
	var bird_moving = bird_animator.get_node("AnimationPlayer")
	bird_moving.play("bird_menu_animation")
	
	var hawk_animator = get_node("Sprites/Hawk/AnimationPlayer")
	hawk_animator.play("hawk_menu_animation")
	
	var shark_animator = get_node("Sprites/Shark")
	shark_animator.play("idle_fish")
	
	var shark_moving = shark_animator.get_node("AnimationPlayer")
	shark_moving.play("shark_menu_animation")
	
	var narval_animator = get_node("Sprites/Narval")
	narval_animator.play("idle")
	
	var narval_moving = narval_animator.get_node("AnimationPlayer")
	narval_moving.play("narval_menu_animation")
	
	var red_cell_animator = get_node("Sprites/RedCell")
	red_cell_animator.play("idle")
	
	var red_cell_moving = red_cell_animator.get_node("AnimationPlayer")
	red_cell_moving.play("red_cell_menu_animation")
	
	var transition = get_node("PlayTransition") as AnimationPlayer
	transition.play_backwards("play_transition")
	
	var arrow_animation = get_node("UI/Version/Arrow/ArrowAnimation") as AnimationPlayer
	arrow_animation.play("aroow_animation_2")
	
	var back_arrow_animation = get_node("UI/ChangesLog/ChangesLogArrow/ArrowAnimation") as AnimationPlayer
	back_arrow_animation.play("aroow_animation")
	
func _process(delta: float) -> void:
	if turn_on_first_level:
		if Global.deep_sea_level_completed == false:
			get_tree().change_scene_to_file(first_level)	
			return
		
		get_tree().change_scene_to_file(choose_level_scene)
			

func _on_quit_button_pressed() -> void:
	cliked_quit_button = true
	var transition = get_node("PlayTransition")
	transition.play("play_transition")
	

func _on_start_button_pressed() -> void:
	cliked_start_button = true	
	var transition = get_node("PlayTransition")
	transition.play("play_transition")
	

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


func _on_play_transition_animation_finished(anim_name: StringName) -> void:	
	if cliked_start_button:
		turn_on_first_level = true
	elif cliked_quit_button:
		get_tree().quit()
	elif cliked_settings_button:
		get_tree().change_scene_to_file(settings_scene_str)


func _on_settings_button_pressed() -> void:
	cliked_settings_button = true
	var transition = get_node("PlayTransition")
	transition.play("play_transition")
	


func _on_open_changes_log_pressed() -> void:
	var changes_log_animator = get_node("ChangesLogAnimation")
	changes_log_animator.play("changes_log_animation")


func _on_close_changes_log_pressed() -> void:
	var changes_log_animator = get_node("ChangesLogAnimation")
	changes_log_animator.play_backwards("changes_log_animation")


func _on_open_changes_log_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_open_changes_log_mouse_exited() -> void:
	can_by_audio_played = true


func _on_close_changes_log_mouse_entered() -> void:
	if can_by_audio_played:
		button_audio.play()
		can_by_audio_played = false


func _on_close_changes_log_mouse_exited() -> void:
	can_by_audio_played = true
