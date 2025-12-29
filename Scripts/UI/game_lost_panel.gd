extends Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	GLOBAL.onGameLost.connect(onGameWasLost)

func onGameWasLost() -> void:
	self.visible = true
	#GameLostPanel.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()
