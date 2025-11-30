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
	
