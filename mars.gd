extends CharacterBody2D

var animator : AnimationPlayer

func  _ready() -> void:
	animator = $Area2D/AnimationPlayer
	animator.play("rotate_mars")
	
	
