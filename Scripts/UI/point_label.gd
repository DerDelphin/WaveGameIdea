extends VBoxContainer

@onready var PointText: Label = %Points
@onready var RequiredPointsLabel: Label = %RequiredLabel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLOBAL.onPointsIncreased.connect(changePointText)
	GLOBAL.onDayEnded.connect(displayRequiredPoints)
	RequiredPointsLabel.text = str(DayInfoManager.getRequiredPoints(0))
	displayRequiredPoints()

func changePointText() -> void:
	PointText.text = str(GLOBAL.points) + " P"

func displayRequiredPoints() -> void:
	RequiredPointsLabel.text = "required: " + str(DayInfoManager.getRequiredPoints(GLOBAL.dayCount-1))
