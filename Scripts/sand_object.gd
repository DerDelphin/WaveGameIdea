extends Area2D

@export var hp :int = 1
@export var pointValue :int = 1
@export_enum("Small", "Strong") var type = "Small"

var damagedSprite : CompressedTexture2D = preload("res://Sprites/strong_sand_obj_damaged.png")
var destructionIndicator = preload("res://Scenes/destruction_point_indicator.tscn")

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
		instance.get_child(0).text = str(pointValue)
		add_sibling(instance)
		queue_free()
	if(type == "Strong"):
		$SandObject.texture = damagedSprite

func addPoints(added: float) -> void:
	GLOBAL.points += added
	GLOBAL.onPointsIncreased.emit()
