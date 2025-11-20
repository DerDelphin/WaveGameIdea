extends Node

var WaveSize = 1
var WaveBaseSpeed = 1
var WavePower = 1
var WaveDelay = 1
var UpgradeList: Array[String] = ["WaveSize+", "WavebaseSpeed+", "WavePower+","WaveDelay-"]

signal WaveDelayChanged
#signal WaveSizeChanged

func _ready() -> void:
	# Ensure that there are no wrong values at start
	if WaveSize < 1: WaveSize = 1
	if WaveBaseSpeed < 1: WaveBaseSpeed = 1
	if WavePower < 1: WavePower = 1
	if WaveDelay > 1: WaveDelay = 1
