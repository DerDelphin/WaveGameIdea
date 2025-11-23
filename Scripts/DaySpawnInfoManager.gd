extends Node

@export var dayInfo: Array[DayDataSet] = []

func getNormalSpawnChance(day: int) -> float:
	if dayInfo.size() < day:
		print("ERROR. No dayData exists for the given day")
		return 0
	elif not dayInfo.is_empty() && day >= 0:
		return dayInfo[day].normalSpawnChance
	elif day < 0:
		print("ERROR. day must be >= 0 !")
		return 0
	else: return 0
	
func getStrongSpawnChance(day: int) -> float:
	if dayInfo.size() < day:
		print("ERROR. No dayData exists for the given day")
		return 0
	elif not dayInfo.is_empty() && day >= 0:
		return dayInfo[day].strongSpawnChance
	elif day < 0:
		print("ERROR. day must be >= 0 !")
		return 0
	else: return 0

func getBuilderSpawnChance(day: int) -> float:
	if dayInfo.size() < day:
		print("ERROR. No dayData exists for the given day")
		return 0
	elif not dayInfo.is_empty() && day >= 0:
		return dayInfo[day].builderSpawnChance
	elif day < 0:
		print("ERROR. day must be >= 0 !")
		return 0
	else: return 0

func getSpawnDuration(day: int) -> float:
	if dayInfo.size() < day:
		print("ERROR. No dayData exists for the given day")
		return 0
	elif not dayInfo.is_empty() && day >= 0:
		return dayInfo[day].spawnDuration
	elif day < 0:
		print("ERROR. day must be >= 0 !")
		return 0
	else: return 0
