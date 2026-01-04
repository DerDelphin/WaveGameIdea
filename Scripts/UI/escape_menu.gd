extends Control

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("PAUSE"):
		visible = !visible
		get_tree().paused = !get_tree().paused


func _on_button_pressed() -> void:
	visible = false
	get_tree().paused = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()
