extends BoxContainer

var filledSprite = preload("res://external assets/sand_Obj_small.png")
var indicatedSprite = preload("res://Sprites/sand_Obj_small_indicated.png")
@onready var sandObjSpawner: SandObjSpawner

func _ready() -> void:
	sandObjSpawner = get_tree().get_first_node_in_group("SandObjSpawner")
	for child in get_children():
		child.texture = indicatedSprite

func _process(delta: float) -> void:
	checkOvercrowdingMeter()
	

func checkOvercrowdingMeter():
	var day = GLOBAL.dayCount
	#1st SandObj Sprite:
	if(sandObjSpawner.spawnedNum > 0.4 * GLOBAL.ObjectsNeededForOvercrowding[day-1]):
		get_child(0).texture = filledSprite
	else: get_child(0).texture = indicatedSprite
	#2nd SandObj Sprite:
	if(sandObjSpawner.spawnedNum > 0.6 * GLOBAL.ObjectsNeededForOvercrowding[day-1]):
		get_child(1).texture = filledSprite
	else: get_child(1).texture = indicatedSprite
	#3rd SandObj Sprite:
	if(sandObjSpawner.spawnedNum > 0.8 * GLOBAL.ObjectsNeededForOvercrowding[day-1]):
		get_child(2).texture = filledSprite
	else: get_child(2).texture = indicatedSprite
	
	#kill condition
	if sandObjSpawner.spawnedNum > GLOBAL.ObjectsNeededForOvercrowding[day-1]:
		GLOBAL.onGameLost.emit()
		GLOBAL.isDayCycleRunning = false
	
