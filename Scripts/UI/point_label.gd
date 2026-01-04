extends VBoxContainer

@onready var PointText: Label = %Points
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GLOBAL.onPointsIncreased.connect(changePointText)
	updateFontColor()
	PointText.text = str(GLOBAL.points) + " P / " + str(DayInfoManager.getRequiredPoints(GLOBAL.dayCount-1))

func changePointText() -> void:
	updateFontColor()
	PointText.text = str(GLOBAL.points) + " P / " + str(DayInfoManager.getRequiredPoints(GLOBAL.dayCount-1))

func updateFontColor() -> void:
	if GLOBAL.isPointGoalAchieved():
		PointText.add_theme_color_override("font_color",Color("fff7ffff"))
	else:
		PointText.add_theme_color_override("font_color",Color("ff6e5aff")) 
