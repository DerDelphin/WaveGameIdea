extends Node2D

@export var lerp_duration : float = 1  # Duration in seconds

@onready var displayText: Label = $Display
@onready var anim: AnimationPlayer = $AnimationPlayer

var elapsed_time : float = 0.0
var start_color : Color
@export var target_color : Color  # Fully transparent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_color = displayText.modulate
	#anim.play("Number_move")


func _process(delta: float):
	elapsed_time += delta
	var lerp_factor = elapsed_time / lerp_duration

	#lerp color
	displayText.modulate = start_color.lerp(target_color, lerp_factor)


func _on_timer_timeout() -> void:
	queue_free()
