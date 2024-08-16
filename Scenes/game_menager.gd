extends Node

var points = 0

func add_points(number_of_point):
	if number_of_point != null:
		points += number_of_point
	else:
		return
	print(points)
