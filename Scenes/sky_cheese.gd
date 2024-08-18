extends Node2D

func _ready() -> void:
	var cheese_animator = get_node("Area2D/AnimatedSprite2D/AnimationPlayer")
	cheese_animator.play("flying_cheese")
