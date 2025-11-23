extends Node


var points: int = 0
var isDayCycleRunning: bool = true
##the current dayTime
var day_time: float = 0.0
var dayCount: int = 1
const DAY_DURATION := 120.0
const PointsNeededPerRound = [100, 200, 300, 380, 500, 680, 760, 850]
const ObjectsNeededForOvercrowding = [100, 60, 40, 30, 30, 30, 30, 30]

signal onPointsIncreased
signal onDayEnded
signal newDayStarted
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
	
func Chance(wahrscheinlichkeit: float) -> bool:
	# Überprüfen, ob die Wahrscheinlichkeit im gültigen Bereich liegt
	if wahrscheinlichkeit <= 0.0 or wahrscheinlichkeit > 1.0:
		push_error("The probability must be between 0 and 1 (inclusive) !")
		return false  # Rückgabe von false im Fehlerfall   
	# Rückgabe von true, wenn eine zufällige Zahl kleiner als die gegebene Wahrscheinlichkeit ist
	return randf() < wahrscheinlichkeit

