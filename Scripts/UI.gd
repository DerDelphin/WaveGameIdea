extends Control

@onready var PointText : Label = %Points
@onready var ClockText : Label = %Clock
@onready var WaveCoolDownDisplay : ProgressBar = %WaveCoolDownBar
@onready var UpgradeButtonsContainer : BoxContainer = $UpgradeButtons
@onready var RequiredPointsLabel : Label = %RequiredLabel
@onready var GameLostPanel : Panel = $GameLostPanel
@onready var VignetteObj : ColorRect = $VignetteShader

var clickSound = preload("res://SFX/click.wav")

#region ready and process
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in UpgradeButtonsContainer.get_children():
		child.visible = false
	GameLostPanel.visible = false
	VignetteObj.visible = false
	GLOBAL.onPointsIncreased.connect(changePointText)
	GLOBAL.onDayEnded.connect(EnableUpgradeMenu)
	WaveCoolDownDisplay.value = 0
	WaveCoolDownDisplay.max_value = UpgradeManager.WaveDelay
	RequiredPointsLabel.text = str(GLOBAL.PointsNeededPerRound[0])
	GLOBAL.onDayEnded.connect(displayRequiredPoints)
	GLOBAL.onGameLost.connect(onGameWasLost)
	displayRequiredPoints()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ClockText.text = get_game_time_string()
	doVignetteEffect()

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
		
	#disable the upgrade menu
	for child in UpgradeButtonsContainer.get_children():
		child.visible = false
	GLOBAL.isDayCycleRunning = true
	GLOBAL.points = 0
	GLOBAL.onPointsIncreased.emit()
	GLOBAL.newDayStarted.emit()
	AudioManager.playAudio(clickSound,1)
func displayUpgrades() -> void:
	#var usedUpgrades: Array[String] = []
	for child in UpgradeButtonsContainer.get_children():
		var Upgrade: String = UpgradeManager.UpgradeList.pick_random()
		#avoid duplicates
		#if not usedUpgrades.has(Upgrade):
		#usedUpgrades.append(Upgrade)
		child.text = Upgrade
			# Disconnect any previously connected function to avoid problems
		if child.pressed.is_connected(onUpgradeButtonWasPressed):
			child.pressed.disconnect(onUpgradeButtonWasPressed)
		child.pressed.connect(func(): onUpgradeButtonWasPressed(Upgrade))


func displayRequiredPoints() -> void:
	RequiredPointsLabel.text = "required: " + str(GLOBAL.PointsNeededPerRound[GLOBAL.dayCount-1])

func doVignetteEffect() -> void:
	if (GLOBAL.day_time/ GLOBAL.DAY_DURATION) > .8 and !GLOBAL.isPointGoalAchieved():
		VignetteObj.visible = true
	else: VignetteObj.visible = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func onGameWasLost() -> void:
	UpgradeButtonsContainer.visible = false
	GameLostPanel.visible = true
