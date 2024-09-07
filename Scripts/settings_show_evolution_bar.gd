extends CheckBox

func _ready() -> void:
	button_pressed = Global.show_evolution_bar


func _on_pressed() -> void:
	if button_pressed:
		Global.show_evolution_bar = true
	else:
		Global.show_evolution_bar = false
