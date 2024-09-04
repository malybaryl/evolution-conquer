extends Area2D

# spawn_radius & spawn_center values here are only
# placeholders, they will change from collision shape radious
# and player position
var spawn_radius = 1000
var spawn_center = Vector2(0, 0)

# spawn_radious < x < spawn_radious_limitation 
# x - position where enemy will apear
@export var spawn_radious_limitation = 2000

var parent
var spawn_radious_node
var spawn_radious_node_shape

func _ready():
	parent = get_parent() as Node2D
	spawn_radious_node = get_node("SpawnRadious")
	spawn_radious_node_shape = spawn_radious_node.shape as CircleShape2D
	spawn_radius = spawn_radious_node_shape.radius * parent.scale.x

func get_spawn_position():
	# sometimes is a trouble with getting parent in _ready() funcion
	if parent == null:
		parent = get_parent() as Node2D
		spawn_radious_node = get_node("SpawnRadious")
		spawn_radious_node_shape = spawn_radious_node.shape as CircleShape2D
		spawn_radius = spawn_radious_node_shape.radius * parent.scale.x
	
	# getting player position
	var spawn_center = parent.position
	print("spawn center: ", spawn_center)
	print("spawn radious: ", spawn_radius)

	# calculation enemy position
	var angle = randf_range(0, PI * 2)
	var distance = randf_range(spawn_radius, spawn_radius + spawn_radious_limitation) 
	
	var position_x = spawn_center.x + cos(angle) * distance
	var position_y = spawn_center.y + sin(angle) * distance
	
	var spawn_position = Vector2(position_x, position_y)
	print("spawn_position: ", spawn_position)
	
	return spawn_position
