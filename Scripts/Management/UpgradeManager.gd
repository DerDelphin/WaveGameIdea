extends Node

var WaveSize = 1
var WaveBaseSpeed = 1
var WavePower = 1
var WaveDelay = 1
var UpgradeList: Array[Upgrade]

signal onUpgradeWasApplied

func _ready() -> void:
	for filePath in DirAccess.get_files_at("res://Data"):
		if filePath.get_extension() == "tres" and !filePath.contains("Standart"):
			UpgradeList.append(load("res://Data/" + filePath))
	
	# Ensure that there are no wrong values at start
	if WaveSize < 1: WaveSize = 1
	if WaveBaseSpeed < 1: WaveBaseSpeed = 1
	if WavePower < 1: WavePower = 1
	if WaveDelay > 1: WaveDelay = 1

func applyUpgrade(upgrade: Upgrade) -> void:
	print("Applying Upgrade: " + upgrade.name)
	match upgrade.id:
		"wave_base_speed": WaveBaseSpeed += .3;
		"wave_power": WavePower += 1
		"wave_delay": WaveDelay -= .3;
		"wave_size": WaveSize += 1
		_: push_warning("No Upgrade was applied...")
	onUpgradeWasApplied.emit()
