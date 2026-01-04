extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = get_y_position()

func get_y_position() -> float:
	var screen_height = get_viewport().size.y  # Bildschirmhöhe holen
	var y_position = screen_height * 0.3 
	return y_position
