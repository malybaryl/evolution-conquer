extends Control

@export var first_stage = true
@export var second_stage = false
@export var third_stage = false

var progress_bar

func _ready() -> void:
	print("Progress bar ready.")
	var stage = 1
	if first_stage:
		stage = 1
	elif second_stage:
		stage = 2
	elif third_stage:
		stage = 3
	set_stage(stage)  # Ensure the correct stage is initialized

func set_value(current_value: float = 0, max_value: float = 100):
	if max_value > 0:
		var new_value = current_value / max_value
		progress_bar.value = new_value
		print("Progress bar value set to: ", new_value)
	else:
		print("Invalid max_value: ", max_value)

func set_stage(stage: int):
	var first_stage_nodes_group = get_node("FirstStage") as Control
	var second_stage_nodes_group = get_node("SecondStage") as Control
	var third_stage_nodes_group = get_node("ThirdStage") as Control
	
	if stage == 1:
		first_stage_nodes_group.visible = true
		second_stage_nodes_group.visible = false
		third_stage_nodes_group.visible = false
		progress_bar = first_stage_nodes_group.get_node("ProgressBar")
	elif stage == 2:
		first_stage_nodes_group.visible = false
		second_stage_nodes_group.visible = true
		third_stage_nodes_group.visible = false
		progress_bar = second_stage_nodes_group.get_node("ProgressBar")
	elif stage == 3:
		first_stage_nodes_group.visible = false
		second_stage_nodes_group.visible = false
		third_stage_nodes_group.visible = true
		progress_bar = third_stage_nodes_group.get_node("ProgressBar")
	print("Progress bar stage set to: ", stage)
	progress_bar.value = 0 
