extends Control

@onready var PointText : Label = $Points
@onready var ClockText : Label = $Clock
@onready var WaveCoolDownDisplay : ProgressBar = $ProgressBar
@onready var UpgradeButtonsContainer : BoxContainer = $UpgradeButtons



#region ready and process
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in UpgradeButtonsContainer.get_children():
		child.visible = false
		
	GLOBAL.onPointsIncreased.connect(changePointText)
	GLOBAL.onDayEnded.connect(EnableUpgradeMenu)
	WaveCoolDownDisplay.value = 0
	WaveCoolDownDisplay.max_value = UpgradeManager.WaveDelay
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
	for child in UpgradeButtonsContainer.get_children():
		child.visible = true
	displayUpgrades()

func onUpgradeButtonWasPressed(upgrade: String) -> void:
	#apply the Upgrade
	match upgrade:
		"WaveBaseSpeed+": UpgradeManager.WaveBaseSpeed += .2;
		"WavePower+": UpgradeManager.WavePower += 1
		"WaveDelay-": UpgradeManager.WaveDelay -= .2; UpgradeManager.WaveDelayChanged.emit()
		"WaveSize+": UpgradeManager.WaveSize += 1
		
	#disabnle the upgrade menu
	for child in UpgradeButtonsContainer.get_children():
		child.visible = false
	GLOBAL.isDayCycleRunning = true
	GLOBAL.points = 0
	GLOBAL.onPointsIncreased.emit()
func displayUpgrades() -> void:
	var usedUpgrades: Array[String] = []
	for child in UpgradeButtonsContainer.get_children():
		var Upgrade: String = UpgradeManager.UpgradeList.pick_random()
		#avoid duplicates
		if not usedUpgrades.has(Upgrade):
			usedUpgrades.append(Upgrade)
			child.text = Upgrade
			
			# Disconnect any previously connected function to avoid problems
			if child.pressed.is_connected(onUpgradeButtonWasPressed):
				child.pressed.disconnect(onUpgradeButtonWasPressed)
			child.pressed.connect(func(): onUpgradeButtonWasPressed(Upgrade))
