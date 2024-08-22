extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var background_animator = get_node("Background_space/AnimationPlayer")
	background_animator.play("bg moving")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
