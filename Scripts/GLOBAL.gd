extends Node

# settings info
var MUSIC: float = 0.5
var SFX: float = 0.5

var resolution = [1280, 720]
var resolution_index: int = 3
var fullscreen: bool = false

# game info
var deep_sea_level_completed: bool = false
var sea_level_completed: bool = false
var sky_level_completed: bool = false
var space_level_completed: bool = false

# UI info
var show_evolution_bar: bool = true

var savegame_path: String = "user://savegame.cfg"

	

func write_savegame() -> void:
	var config = ConfigFile.new()

	config.set_value("settings", "MUSIC", MUSIC)
	config.set_value("settings", "SFX", SFX)
	config.set_value("settings", "resolution", resolution)
	config.set_value("settings", "resolution_index", resolution_index)
	config.set_value("settings", "fullscreen", fullscreen)

	config.set_value("game", "deep_sea_level_completed", deep_sea_level_completed)
	config.set_value("game", "sea_level_completed", sea_level_completed)
	config.set_value("game", "sky_level_completed", sky_level_completed)
	config.set_value("game", "space_level_completed", space_level_completed)

	config.set_value("ui", "show_evolution_bar", show_evolution_bar)

	var err = config.save(savegame_path)
	if err == OK:
		print("Game saved correctly")
	else:
		print("error save game: ", err)

func load_savegame() -> void:
	var config = ConfigFile.new()


	var err = config.load(savegame_path)
	if err == OK:
		
		MUSIC = config.get_value("settings", "MUSIC", MUSIC)
		SFX = config.get_value("settings", "SFX", SFX)
		resolution = config.get_value("settings", "resolution", resolution)
		resolution_index = config.get_value("settings", "resolution_index", resolution_index)
		fullscreen = config.get_value("settings", "fullscreen", fullscreen)


		deep_sea_level_completed = config.get_value("game", "deep_sea_level_completed", deep_sea_level_completed)
		sea_level_completed = config.get_value("game", "sea_level_completed", sea_level_completed)
		sky_level_completed = config.get_value("game", "sky_level_completed", sky_level_completed)
		space_level_completed = config.get_value("game", "space_level_completed", space_level_completed)


		show_evolution_bar = config.get_value("ui", "show_evolution_bar", show_evolution_bar)

		print("Game loaded corectly")
	else:
		print("error game loaded: ", err)
