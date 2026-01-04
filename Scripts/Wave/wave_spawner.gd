extends Node

@onready var WaveObj:PackedScene = preload("res://Scenes/Wave/wave.tscn")
@onready var WaveObjBig:PackedScene = preload("res://Scenes/Wave/wave_big.tscn")
@onready var WaveObjHuge:PackedScene = preload("res://Scenes/Wave/wave_huge.tscn")
@onready var PreWave:PackedScene = preload("res://Scenes/pre_wave.tscn")
@onready var CooldownTimer : Timer = $Timer

signal cooldown_updated(cooldown_percent : float)
var canSpawn: bool = true

func _ready() -> void:
	#spawn preWave once
	var instance = PreWave.instantiate()
	add_child(instance)
	
	CooldownTimer.wait_time = UpgradeManager.WaveDelay
	UpgradeManager.WaveDelayChanged.connect(
		func(): CooldownTimer.wait_time = clamp(UpgradeManager.WaveDelay,0.001,100000))
	var waveCoolDownBar = get_tree().get_first_node_in_group("WaveCoolDownBar")
	if(waveCoolDownBar.has_method("updateCooldownDisplay")):
		cooldown_updated.connect(waveCoolDownBar.updateCooldownDisplay)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("MouseClick") and canSpawn and GLOBAL.isDayCycleRunning:
		spawn()
	#if not CooldownTimer.is_stopped():  ###rescource heavy###
	cooldown_updated.emit(CooldownTimer.time_left)

func spawn() -> void:
	canSpawn = false
	CooldownTimer.start()
	
	var instane: Node = getWaveToSpawn()
	instane.global_position = Vector2(get_viewport().get_mouse_position().x, get_y_position()) 
	add_child(instane)

##Help function that determines the correct Wave to spawn and returns it
func getWaveToSpawn() -> Node:
	if UpgradeManager.WaveSize <= 0: return WaveObj.instantiate()
	match UpgradeManager.WaveSize:
		1: return WaveObj.instantiate()
		2: return WaveObjBig.instantiate()
		3: return WaveObjHuge.instantiate()
		_: return WaveObjHuge.instantiate()

func get_y_position() -> float:
	return get_tree().get_first_node_in_group("spawner_line").global_position.y

func _on_timer_timeout() -> void: canSpawn = true
