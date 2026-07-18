extends HBoxContainer

var clickSound = preload("res://SFX/click.wav")

@onready var upgradeLabel = $"../Upade Describtion/Label"
var upgradeDescriptions: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	displayUpgrades()


func displayUpgrades() -> void:
	#var usedUpgrades: Array[String] = []
	for child in get_children():
		var usedUpgrade: Upgrade = UpgradeManager.UpgradeList.pick_random()
		upgradeDescriptions.append(usedUpgrade.describtion)
		#avoid duplicates
		#if not usedUpgrades.has(Upgrade):
		#usedUpgrades.append(Upgrade)
		child.text = usedUpgrade.name
			# Disconnect any previously connected function to avoid problems
		if child.pressed.is_connected(onUpgradeButtonWasPressed):
			child.pressed.disconnect(onUpgradeButtonWasPressed)
		child.pressed.connect(func(): onUpgradeButtonWasPressed(usedUpgrade))

func onUpgradeButtonWasPressed(upgrade: Upgrade) -> void:
	#apply the Upgrade
	UpgradeManager.applyUpgrade(upgrade)
	#disable the upgrade menu
	for child in get_children():
		child.visible = false
	#change the scene
	get_tree().scene_changed.connect(onNewSceneIsReady)
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func onNewSceneIsReady() ->void:
	#Prepare another round once the world scene has loaded
	AudioManager.playAudio(clickSound,1)


func on_button1_hover() -> void:
	if(upgradeLabel != null): upgradeLabel.text = upgradeDescriptions[0]


func _on_upgrade_button_2_mouse_entered() -> void:
	if(upgradeLabel != null): upgradeLabel.text = upgradeDescriptions[1]


func _on_upgrade_button_3_mouse_entered() -> void:
	if(upgradeLabel != null): upgradeLabel.text = upgradeDescriptions[2]
