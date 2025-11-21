extends Node


var points: int = 0
var isDayCycleRunning: bool = true
##the current dayTime
var day_time: float = 0.0
var dayCount: int = 1
const DAY_DURATION := 120.0
const PointsNeededPerRound = [40, 100, 200, 400, 600, 880, 1000, 2000]
const ObjectsNeededForOvercrowding = [100, 70, 40, 40, 40, 40, 40, 40]

signal onPointsIncreased
signal onDayEnded
signal onGameLost

func _process(delta: float) -> void:
	if(isDayCycleRunning):
		day_time += delta
	# Falls ein neuer Tag beginnt, wieder bei 0 starten
	if day_time >= DAY_DURATION:
		if points < PointsNeededPerRound[dayCount-1]:
			print("You lost! The water god is mad at you. You lost your power")
			onGameLost.emit()
		day_time = 0.0
		dayCount += 1
		onDayEnded.emit()
		isDayCycleRunning = false
		
func isPointGoalAchieved() -> bool:
	return points >= PointsNeededPerRound[dayCount-1]
