extends Control

var level1 = "res://Scenes/main_scene.tscn"
var level2 = "res://Scenes/ocean_level.tscn"
var level3 = "res://Scenes/sky_level.tscn"
var level4 = "res://Scenes/space_level.tscn"
var main_menu = "res://Scenes/main_menu.tscn"

var cliked_back = false
var cliked_level_deep_sea = false
var cliked_level_sea = false
var cliked_level_sky = false
var cliked_level_space = false


@onready var transition = get_node("Transition/Transition")


# Called when the node enters the scene tree for the first time.
func _ready():
	# mechanics
	
	# deep sea
	var deep_sea_text = get_node("Level1/DeepOcean")
	var deep_sea_blur = get_node("Level1/Blur")
	var deep_sea____ = get_node("Level1/???")
	var deep_sea_button = get_node("Level1/Button") as Button
	
	if Global.deep_sea_level_completed:
		deep_sea_text.visible = true
		deep_sea_blur.visible = false
		deep_sea____.visible = false
		deep_sea_button.disabled = false
	else:
		deep_sea_text.visible = false
		deep_sea_blur.visible = true
		deep_sea____.visible = true
		deep_sea_button.disabled = true
		
	# sea
	var sea_text = get_node("Level2/Ocean")
	var sea_blur = get_node("Level2/Blur")
	var sea____ = get_node("Level2/???")
	var sea_button = get_node("Level2/Button") as Button
	
	if Global.sea_level_completed:
		sea_text.visible = true
		sea_blur.visible = false
		sea____.visible = false
		sea_button.disabled = false
	else:
		sea_text.visible = false
		sea_blur.visible = true
		sea____.visible = true
		sea_button.disabled = true
		
	# sky
	var sky_text = get_node("Level3/Sky")
	var sky_blur = get_node("Level3/Blur")
	var sky____ = get_node("Level3/???")
	var sky_button = get_node("Level3/Button") as Button
	
	if Global.sky_level_completed:
		sky_text.visible = true
		sky_blur.visible = false
		sky____.visible = false
		sky_button.disabled = false
	else:
		sky_text.visible = false
		sky_blur.visible = true
		sky____.visible = true
		sky_button.disabled = true

	# sky
	var space_text = get_node("Level4/Space")
	var space_blur = get_node("Level4/Blur")
	var space____ = get_node("Level4/???")
	var space_button = get_node("Level4/Button") as Button
	
	if Global.space_level_completed:
		space_text.visible = true
		space_blur.visible = false
		space____.visible = false
		space_button.disabled = false
	else:
		space_text.visible = false
		space_blur.visible = true
		space____.visible = true
		space_button.disabled = true
		
	# animations
	var background_animator = get_node("Background_space/AnimationPlayer")
	background_animator.play("bg moving")
	
	transition.play("transition")


func _on_button_level1_pressed() -> void:
	cliked_level_deep_sea = true
	transition.play_backwards("transition")


func _on_button_level2_pressed() -> void:
	cliked_level_sea = true
	transition.play_backwards("transition")


func _on_button_level4_pressed() -> void: # level 3
	cliked_level_sky = true
	transition.play_backwards("transition")

func _on_button_pressed() -> void: # level 4
	cliked_level_space = true
	transition.play_backwards("transition")


func _on_back_pressed() -> void:
	cliked_back = true
	transition.play_backwards("transition")


func _on_transition_animation_finished(anim_name: StringName) -> void:
	if cliked_back:
		get_tree().change_scene_to_file(main_menu)
	elif cliked_level_deep_sea:
		get_tree().change_scene_to_file(level1)
	elif cliked_level_sea:
		get_tree().change_scene_to_file(level2)
	elif cliked_level_sky:
		get_tree().change_scene_to_file(level3)
	elif cliked_level_space:
		get_tree().change_scene_to_file(level4)
