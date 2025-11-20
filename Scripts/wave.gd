extends Node2D

@export var speed = 30
@onready var timer:Timer = %KillTimer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_kill_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2.UP * delta * speed * UpgradeManager.WaveBaseSpeed

func _on_kill_timer_timeout() -> void: queue_free()

func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("SandObj")):
		area.TakeDamage(UpgradeManager.WavePower)
	if(area.is_in_group("Beach")):
		queue_free()
