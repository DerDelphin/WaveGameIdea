extends Node

##The DayDataSet in use
var dayInfo: DayDataSet = preload("res://Data/StandartDayDataSet.tres")

func getNormalSpawnChance(day: int) -> float:
	if not _isGivenDayValid(day): return 0
	else: return dayInfo.days[day].normalSpawnChance
	
func getStrongSpawnChance(day: int) -> float:
	if not _isGivenDayValid(day): return 0
	else: return dayInfo.days[day].strongSpawnChance

func getBuilderSpawnChance(day: int) -> float:
	if not _isGivenDayValid(day): return 0
	else: return dayInfo.days[day].builderSpawnChance

func getSpawnDuration(day: int) -> float:
	if not _isGivenDayValid(day): return 0
	else: return dayInfo.days[day].spawnDuration

func getRequiredPoints(day:int) -> int:
	if not _isGivenDayValid(day): return 0
	else: return dayInfo.days[day].PointsNeeded

func getOvercrowdNumber(day:int) -> int:
	if not _isGivenDayValid(day): return 0
	else: return dayInfo.days[day].ObjectsNeededForOvercrowding

##Checks for possible errors, like an empty day array or a day
##value for a day that does not exist in the used DayDataSet
func _isGivenDayValid(day: int) -> bool:
	#is it empty?
	if dayInfo.days.is_empty(): 
		push_error("ERROR: DayInfo is empty!")
		return false
	#is day bigger than the array's size?
	if dayInfo.days.size() < day:
		push_error("ERROR: No dayData exists for the given day")
		return false
		#is day smaller than 0?
	if day < 0:
		push_error("ERROR: Day must be >= 0 !")
		return false
	else: return true
