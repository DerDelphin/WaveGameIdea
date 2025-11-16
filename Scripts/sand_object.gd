extends Area2D

@export var hp :int = 1
@export var pointValue :int = 1
@export_enum("Small", "Strong") var type = "Small"

var damagedSprite : CompressedTexture2D = preload("res://Sprites/strong_sand_obj_damaged.png")

func TakeDamage() -> void:
	hp -= 1
	if(hp < 1):
		addPoints(pointValue)
		queue_free()
	if(type == "Strong"):
		$SandObject.texture = damagedSprite

func addPoints(added: float) -> void:
	GLOBAL.points += added
	GLOBAL.onPointsIncreased.emit()
