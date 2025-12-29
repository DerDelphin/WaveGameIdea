extends AudioStreamPlayer

var beachMusic = preload("res://Music/beach.wav")
var UpgradeMenuMusic = preload("res://Music/beach calm.wav")
var DayEndedMusic = preload("res://Music/beach_day_ended.wav")
var LooseMusic = preload("res://Music/loose.wav")

var PointGoalReachedSFX = preload("res://SFX/succes.wav")
var isLocked = false

func _ready() -> void:
	self.playBeachMusic()
	GLOBAL.onDayEnded.connect(playDayEndedMusic)
	GLOBAL.onGameLost.connect(playLooseMusic)
	GLOBAL.onPointsIncreased.connect(_on_PointsIncresed)

func playUpgradeMenuMusic()-> void:
	if(isLocked):return
	self.stop()
	self.stream = UpgradeMenuMusic
	self.play()
func playBeachMusic()-> void:
	if(isLocked):return
	self.stop()
	self.stream = beachMusic
	self.play()
func playDayEndedMusic()-> void:
	if(isLocked):return
	self.stop()
	self.stream = DayEndedMusic
	self.play()
func playLooseMusic()-> void:
	isLocked = true
	self.stop()
	self.stream = LooseMusic
	self.play()

func _on_PointsIncresed() -> void:
	if GLOBAL.points == DayInfoManager.getRequiredPoints(GLOBAL.dayCount-1):
		AudioManager.playAudio(PointGoalReachedSFX,1)
func _on_finished() -> void:
	match stream:
		beachMusic: playBeachMusic()
		UpgradeMenuMusic: playUpgradeMenuMusic()
		DayEndedMusic: playUpgradeMenuMusic()
		LooseMusic: pass


func _on_bg_water_sounds_finished() -> void:
	%"BG Water Sounds".play()
