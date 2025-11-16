extends Control

@onready var PointText : Label = $Points
@onready var ClockText : Label = $Clock
@onready var WaveCoolDownDisplay : ProgressBar = $ProgressBar
@onready var NextDayButton: Button = $NextDayButton

#region ready and process
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NextDayButton.visible = false
	GLOBAL.onPointsIncreased.connect(changePointText)
	GLOBAL.onDayEnded.connect(EnableUpgradeMenu)
	WaveCoolDownDisplay.value = 0
	WaveCoolDownDisplay.max_value = GLOBAL.waveCoolDown
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ClockText.text = get_game_time_string()

#endregion
#region PointLogic
func changePointText() -> void:
	PointText.text = str(GLOBAL.points) + " P"
#endregion
#region CoolDownDisplay
func updateCooldownDisplay(newValue : float) -> void:
	WaveCoolDownDisplay.value = newValue

#endregion

func get_game_time_string() -> String:
	var t = GLOBAL.day_time  # Sekunden innerhalb des 4-Minuten-Tages
	
	# Spielzeit umrechnen
	var hours = int((t / GLOBAL.DAY_DURATION) * 24)
	var minutes = int(((t / GLOBAL.DAY_DURATION) * 24 - hours) * 60)

	# Formatieren
	return "%02d:%02d" % [hours, minutes]

func EnableUpgradeMenu() -> void:
	NextDayButton.visible = true


func _on_next_day_button_pressed() -> void:
	NextDayButton.visible = false
	GLOBAL.isDayCycleRunning = true
	GLOBAL.points = 0
	GLOBAL.onPointsIncreased.emit()
