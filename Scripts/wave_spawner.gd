extends Node

@onready var WaveObj:PackedScene = preload("res://Scenes/wave.tscn")
@onready var PreWave:PackedScene = preload("res://Scenes/pre_wave.tscn")
@onready var CooldownTimer : Timer = $Timer

signal cooldown_updated(cooldown_percent : float)
var canSpawn: bool = true

func _ready() -> void:
	var instance = PreWave.instantiate()
	add_child(instance)
	
	CooldownTimer.wait_time = UpgradeManager.WaveDelay
	UpgradeManager.WaveDelayChanged.connect(
		func(): CooldownTimer.wait_time = clamp(UpgradeManager.WaveDelay,0.001,100000))
	var uiObj = get_tree().get_first_node_in_group("UI")
	if(uiObj.has_method("updateCooldownDisplay")):
		cooldown_updated.connect(uiObj.updateCooldownDisplay)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("MouseClick") and canSpawn and GLOBAL.isDayCycleRunning:
		spawn()
	if not CooldownTimer.is_stopped():
		cooldown_updated.emit(CooldownTimer.time_left)
		
func spawn() -> void:
	canSpawn = false
	CooldownTimer.start()
	
	var instane: Node = WaveObj.instantiate()
	instane.global_position = Vector2(get_viewport().get_mouse_position().x, get_y_position()) 
	add_child(instane)

func get_y_position() -> float:
	var screen_height = get_viewport().size.y  # Bildschirmhöhe holen
	var y_position = screen_height * 0.8  # 20% vom unteren Rand entfernt (also 80% der Höhe)
	return y_position

func _on_timer_timeout() -> void: canSpawn = true


func _on_audio_stream_player_finished() -> void:
	$"../AudioStreamPlayer".play()


func _on_bg_music_finished() -> void:
	$"../Bg music".play()
