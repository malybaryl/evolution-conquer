extends Node

# settings info
var MUSIC = .5
var SFX = .5

func float_to_db(volume :float):
	return 20 * (log(volume) / log(10))


# game info
var deep_sea_level_completed = false
var sea_level_completed = false
var sky_level_completed = false
var space_level_completed = false

# UI info
var show_evolution_bar = true
