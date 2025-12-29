extends ColorRect

var heartBeatSound = preload("res://SFX/heartbeat.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	doVignetteEffect()

func doVignetteEffect() -> void:
	if (GLOBAL.day_time/ GLOBAL.DAY_DURATION) > .8 and !GLOBAL.isPointGoalAchieved():
		visible = true
		AudioManager.playAudioWithRefId("H-Beat", heartBeatSound, 1.6)
	else: visible = false
