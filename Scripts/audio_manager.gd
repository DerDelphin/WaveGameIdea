extends Node

signal finished()
func playAudio(clip: AudioStream, volume: float) ->void:
	if clip != null:
		var clipPlayer := AudioStreamPlayer.new()
		add_child(clipPlayer)
		clipPlayer.stream = clip
		if(volume > 0) : clipPlayer.volume_db = volume
		clipPlayer.play()
		#connect(Da drin ist eine virtuelle Funktion)
		clipPlayer.finished.connect(func(): clipPlayer.queue_free())
	else: push_warning("Unable to play Sound")
	
func playAudioWithCutOff(clip: AudioStream, volume: float, end:float) ->void:
	if clip != null:
		var clipPlayer := AudioStreamPlayer.new()
		add_child(clipPlayer)
		clipPlayer.stream = clip
		if(volume > 0) : clipPlayer.volume_db = volume
		clipPlayer.play()
		get_tree().create_timer(end).timeout.connect(func(): clipPlayer.stop())
		#connect(Da drin ist eine virtuelle Funktion)
		clipPlayer.finished.connect(func(): finished.emit(); clipPlayer.queue_free())
	else: push_warning("Unable to play Sound")

func playAudioWithRefId(id: String,clip: AudioStream, volume: float) -> void:
	if clip != null:
		for child in get_children():
			if child.name == id:
				print("This Playback already exits!")
				return
		var clipPlayer := AudioStreamPlayer.new()
		clipPlayer.name = str(id)
		add_child(clipPlayer)
		clipPlayer.stream = clip
		if(volume > 0) : clipPlayer.volume_db = volume
		clipPlayer.play()
		#connect(Da drin ist eine virtuelle Funktion)
		clipPlayer.finished.connect(func(): clipPlayer.queue_free())
	else: push_warning("Unable to play Sound")
	
func cancelAudio(id: String) -> void:
	#Loop over every AudioStreamPlayer-child and check if it matches the id
	for child in get_children():
		if child.name == id and child is AudioStreamPlayer:
			child.stop()
			child.queue_free()
			return
	print("Unable to find child with id: " + id)
