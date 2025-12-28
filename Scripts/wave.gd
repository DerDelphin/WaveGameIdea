extends Node2D

@export var speed = 325
@onready var timer:Timer = %KillTimer
@onready var streamPlayer: AudioStreamPlayer = %WaveMoveSoundPlayer


var moveSound = preload("res://SFX/wave move.wav")
var impactSound = preload("res://SFX/wave impact2.wav")
var normalWaveSprite = preload("res://Sprites/Wave/wave.png")
var bigWaveSprite = preload("res://Sprites/Wave/Wave_large.png")
var largeWaveSprite = preload("res://Sprites/Wave/wave_extraLarge.png")
var combo = -1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_kill_timer_timeout)
	SetWaveSpriteAndHitBox()
	streamPlayer.stream = moveSound
	streamPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2.UP * delta * speed * UpgradeManager.WaveBaseSpeed
	

func _on_kill_timer_timeout() -> void: queue_free()

func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("SandObj")):
		area.TakeDamage(UpgradeManager.WavePower)
		combo += 1
	if(area.is_in_group("Beach")):
		addComboPoints()
		AudioManager.playAudio(impactSound,.04)
		streamPlayer.stop()
		queue_free()

##this function adds additional combo points, which are earned for destroying multiple Sandj with a single wave
func addComboPoints() -> void:
	if combo > 0: GLOBAL.points += combo; print("COMBO!!!" + str(combo))

func SetWaveSpriteAndHitBox():
	
	match UpgradeManager.WaveSize:
		1:
			$Wave.texture = normalWaveSprite
			$HitBox.disabled = false
			$HitBoxBig.disabled = true
			$HitBoxLarge.disabled = true
		2:
			$Wave.texture = bigWaveSprite
			$HitBox.disabled = true
			$HitBoxBig.disabled = false
			$HitBoxLarge.disabled = true
		3:
			$Wave.texture = largeWaveSprite
			$HitBox.disabled = true
			$HitBoxBig.disabled = true
			$HitBoxLarge.disabled = false
		_:
			$Wave.texture = normalWaveSprite
			$HitBox.disabled = false
			$HitBoxBig.disabled = true
			$HitBoxLarge.disabled = true
