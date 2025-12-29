extends HBoxContainer

var clickSound = preload("res://SFX/click.wav")
var normalBGMusic = preload("res://Music/beach.wav")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		child.visible = false
	GLOBAL.onDayEnded.connect(EnableUpgradeMenu)

func EnableUpgradeMenu() -> void:
	for child in get_children():
		child.visible = true
	displayUpgrades()


func displayUpgrades() -> void:
	#var usedUpgrades: Array[String] = []
	for child in get_children():
		var Upgrade: String = UpgradeManager.UpgradeList.pick_random()
		#avoid duplicates
		#if not usedUpgrades.has(Upgrade):
		#usedUpgrades.append(Upgrade)
		child.text = Upgrade
			# Disconnect any previously connected function to avoid problems
		if child.pressed.is_connected(onUpgradeButtonWasPressed):
			child.pressed.disconnect(onUpgradeButtonWasPressed)
		child.pressed.connect(func(): onUpgradeButtonWasPressed(Upgrade))

func onUpgradeButtonWasPressed(upgrade: String) -> void:
	#apply the Upgrade
	match upgrade:
		"WaveBaseSpeed+": UpgradeManager.WaveBaseSpeed += .2;
		"WavePower+": UpgradeManager.WavePower += 1
		"WaveDelay-": UpgradeManager.WaveDelay -= .2; UpgradeManager.WaveDelayChanged.emit()
		"WaveSize+": UpgradeManager.WaveSize += 1
		
	#disable the upgrade menu
	for child in get_children():
		child.visible = false
	GLOBAL.isDayCycleRunning = true
	GLOBAL.points = 0
	GLOBAL.onPointsIncreased.emit()
	GLOBAL.newDayStarted.emit()
	AudioManager.playAudio(clickSound,1)
	get_tree().get_first_node_in_group("BGM").stream = normalBGMusic
	get_tree().get_first_node_in_group("BGM").play()
