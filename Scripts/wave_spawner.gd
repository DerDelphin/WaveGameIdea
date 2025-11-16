extends Node

@onready var WaveObj:PackedScene = preload("res://Scenes/wave.tscn")
@onready var CooldownTimer : Timer = $Timer

signal cooldown_updated(cooldown_percent : float)
var canSpawn: bool = true

func _ready() -> void:
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
	instane.global_position = Vector2(get_viewport().get_mouse_position().x, 400) 
	add_child(instane)

func _on_timer_timeout() -> void: canSpawn = true
