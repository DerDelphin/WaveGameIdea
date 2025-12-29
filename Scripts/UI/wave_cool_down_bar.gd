extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = 0
	max_value = UpgradeManager.WaveDelay
	
func updateCooldownDisplay(newValue : float) -> void:
	value = newValue
