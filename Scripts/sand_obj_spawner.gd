extends Node2D

@onready var SandObj:PackedScene = preload("res://Scenes/sand_object.tscn")
@onready var StrongSandObj:PackedScene = preload("res://Scenes/strong_sand_object.tscn")

var canSpawn : bool = true

func _ready() -> void:
	GLOBAL.onDayEnded.connect(endSpawnCycle)

func spawn() -> void:
	#generate a random number and then spawn the normal or heavy sand obj
	var rnd = randi_range(0,100)
	var instance: Node
	if(rnd > 77):
		instance = StrongSandObj.instantiate()
	elif (rnd <= 77):
		instance = SandObj.instantiate()
	 
	#eitherway position it and then add it to the scene
	instance.global_position = get_random_screen_position()
	add_child(instance)

## Funktion zum Berechnen einer zufälligen Position im oberen Bereich des Bildschirms
func get_random_screen_position() -> Vector2:
	var screen_size = get_viewport().size
	
	# Definiere den oberen Bereich (hier 30% der Bildschirmhöhe)
	var min_y = 15
	var max_y = screen_size.y * 0.3  # 30% der Bildschirmhöhe als Obergrenze für den Bereich
	
	# Zufällige Y-Position im oberen Bereich
	var random_y = randf_range(min_y, max_y)
	
	# Zufällige X-Position im gesamten Bildschirmbereich
	var random_x = randf_range(0, screen_size.x)
	
	return Vector2(random_x, random_y)

func _on_timer_timeout() -> void:
	if(canSpawn):spawn()

func endSpawnCycle() -> void:
	canSpawn = false
