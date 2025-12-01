extends Area2D

@export var hp :int = 1
@export var pointValue :int = 1
@export_enum("Small", "Strong","Builder") var type = "Small"

var damagedSprite : CompressedTexture2D = preload("res://Sprites/big castle_destroyed.png")
var destructionIndicator = preload("res://Scenes/destruction_point_indicator.tscn")
#sounds
var destroyedSound = preload("res://SFX/sand_destroyed.wav")
var damagedSound = preload("res://SFX/wave impact.wav")

func TakeDamage(amount:int = 0) -> void:
	# default (no amount provided)
	if(amount == 0):
		hp -= 1
	# other (amount provided)
	else: 
		hp -= amount
	if(hp < 1):
		addPoints(pointValue)
		var instance = destructionIndicator.instantiate()
		instance.global_position = self.global_position
		instance.get_child(0).text = "+ " + str(pointValue)
		add_sibling(instance)
		var sandObjSpawner = get_tree().get_first_node_in_group("SandObjSpawner")
		sandObjSpawner.spawnedNum -= 1
		AudioManager.playAudio(destroyedSound,1)
		queue_free()
	if(type == "Strong" and hp > 0):
		$SandObject.texture = damagedSprite
		AudioManager.playAudio(damagedSound,1)

func addPoints(added: float) -> void:
	
	GLOBAL.points += added
	GLOBAL.onPointsIncreased.emit()



func _on_timer_timeout() -> void:
	pointValue += 1
	print("This B Castle is now worth: " + str(pointValue))
