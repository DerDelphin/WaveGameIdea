extends AudioStreamPlayer

var beachMusic = preload("res://Music/beach.wav")
var UpgradeMenuMusic = preload("res://Music/beach calm.wav")
var DayEndedMusic = preload("res://Music/beach_day_ended.wav")
var LooseMusic = preload("res://Music/loose.wav")

var PointGoalReachedSFX = preload("res://SFX/succes.wav")
#var isLocked = false
var canPlayGoalReachedSound = true

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	self.playBeachMusic()
	self.finished.connect(_on_finished)
	get_tree().scene_changed.connect(playNewMusicBasedOnScene)
	GLOBAL.onDayEnded.connect(playDayEndedMusic)
	GLOBAL.onGameLost.connect(playLooseMusic)
	GLOBAL.onPointsIncreased.connect(_on_PointsIncresed)
	#GLOBAL.newDayStarted.connect(playBeachMusic)

func playUpgradeMenuMusic()-> void:
	self.stop()
	self.stream = UpgradeMenuMusic
	self.play()
func playBeachMusic()-> void:
	self.stop()
	self.stream = beachMusic
	self.play()
func playDayEndedMusic()-> void:
	canPlayGoalReachedSound = true
	self.stop()
	self.stream = DayEndedMusic
	self.play()
func playLooseMusic()-> void:
	self.stop()
	self.stream = LooseMusic
	self.play()

##plays a audio clue that player met the requirement
func _on_PointsIncresed() -> void:
	if GLOBAL.points >= DayInfoManager.getRequiredPoints(GLOBAL.dayCount-1) and canPlayGoalReachedSound:
		AudioManager.playAudio(PointGoalReachedSFX,1)
		canPlayGoalReachedSound = false
func _on_finished() -> void:
	match stream:
		beachMusic: playBeachMusic()
		UpgradeMenuMusic: playUpgradeMenuMusic()
		DayEndedMusic: pass
		LooseMusic: pass
func playNewMusicBasedOnScene() ->void:
	#stop playing and start playing the music that is supposed to play for the current scene
	stop()
	match get_tree().current_scene.name:
		"World": playBeachMusic()
		"Shop Screen" : playUpgradeMenuMusic()
		_ : push_error("MusicManager: Unexpected scene! No Music will be played!")

func _on_bg_water_sounds_finished() -> void:
	%"BG Water Sounds".play()
