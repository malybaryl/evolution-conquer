extends AudioStreamPlayer

var songs = [
	preload("res://Assets/Music/song1.mp3"),
	preload("res://Assets/Music/song2.mp3"),
	preload("res://Assets/Music/song3.mp3")
]

var current_song_index = 0


func play_song():
	stream = songs[current_song_index]
	play()

func _on_finished():
	current_song_index += 1
	if current_song_index >= songs.size():
		current_song_index = 0
	play_song()
