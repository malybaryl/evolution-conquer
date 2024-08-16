extends Camera2D

@export var limit_rect: Rect2

func _ready():
	limit_left = limit_rect.position.x
	limit_top = limit_rect.position.y
	limit_right = limit_rect.position.x + limit_rect.size.x
	limit_bottom = limit_rect.position.y + limit_rect.size.y

	make_current()  # Ustawienie tej kamery jako aktualnej

func _process(delta):
	if not is_current():
		return
	
	var player_position = get_parent().global_position
	global_position = player_position.clamped(Vector2(limit_left, limit_top), Vector2(limit_right, limit_bottom))
