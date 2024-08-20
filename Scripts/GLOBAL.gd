extends Node

var MUSIC = .5
var SFX = .5

func float_to_db(volume :float):
	return 20 * (log(volume) / log(10))
