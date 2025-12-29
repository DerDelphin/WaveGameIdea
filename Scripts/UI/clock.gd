extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = get_game_time_string()

func get_game_time_string() -> String:
	var t = GLOBAL.day_time  # Sekunden innerhalb des 4-Minuten-Tages
	
	# Spielzeit umrechnen
	var hours = int((t / GLOBAL.DAY_DURATION) * 24)
	var minutes = int(((t / GLOBAL.DAY_DURATION) * 24 - hours) * 60)

	# Formatieren
	return "%02d:%02d" % [hours, minutes]
