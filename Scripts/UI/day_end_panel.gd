extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	GLOBAL.onDayEnded.connect(displayPanel)

func displayPanel() ->void:
	$"../GameLostPanel".visible = false
	visible = true


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/shop_screen.tscn")
