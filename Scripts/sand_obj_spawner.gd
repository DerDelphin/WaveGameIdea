extends Node2D
class_name SandObjSpawner

@onready var SandObj:PackedScene = preload("res://Scenes/sand_object.tscn")
@onready var StrongSandObj:PackedScene = preload("res://Scenes/strong_sand_object.tscn")
@onready var builderCastle: PackedScene = preload("res://Scenes/builder_castle.tscn")
@onready var timer: Timer = $Timer
var spawnedNum: int = 0
var DaySpawnInfoGiver

func _ready() -> void:
	DaySpawnInfoGiver = get_tree().get_first_node_in_group("DaySpawnInfoManager")
	timer.wait_time = DaySpawnInfoGiver.getSpawnDuration(GLOBAL.dayCount-1)
	GLOBAL.newDayStarted.connect(
		func():timer.wait_time = DaySpawnInfoGiver.getSpawnDuration(GLOBAL.dayCount-1))

func spawn() -> void:
	maybeSpawnBuilderCastle()
	#spawn a normal and or heavy sandObj based on their castle spawn chances
	
	##TODO: implement the logic for spawnChances, so that this sandObjSpawner can finally adjust the difficulty
	var instance: Node
	if(GLOBAL.Chance(DaySpawnInfoGiver.getStrongSpawnChance(GLOBAL.dayCount-1))):
		instance = StrongSandObj.instantiate()
	else:
		instance = SandObj.instantiate()
	#just in case nothing was spawned, exit.
	if(instance == null): return
	
	#position and then add the instance to the scene
	instance.global_position = get_random_screen_position()
	add_child(instance)
	spawnedNum += 1

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
	if(GLOBAL.isDayCycleRunning):spawn()
	
func maybeSpawnBuilderCastle()-> void:
	var spawnChance: float = DaySpawnInfoGiver.getBuilderSpawnChance(GLOBAL.dayCount-1)
	if spawnChance == 0:
		return
	#spawn based on the build castle spawn chance
	var instance: Node
	if(GLOBAL.Chance(spawnChance)):
		instance = builderCastle.instantiate()
		instance.global_position = get_random_screen_position()
		add_child(instance)
		spawnedNum += 1
