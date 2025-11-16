extends Node

var waveCoolDown : float =  1
var points: int = 0
var isDayCycleRunning: bool = true
##the current dayTime
var day_time: float = 0.0
const DAY_DURATION := 10.0

signal onPointsIncreased
signal onDayEnded

func _process(delta: float) -> void:
	if(isDayCycleRunning):
		day_time += delta
	# Falls ein neuer Tag beginnt, wieder bei 0 starten
	if day_time >= DAY_DURATION:
		day_time = 0.0
		print("neuer Tag")
		onDayEnded.emit()
		isDayCycleRunning = false
