extends Node

func _ready():
	$PauseScreen.visible = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
		$PauseScreen.visible = true

	if event.is_action_pressed("click") and get_tree().paused == true:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		get_tree().paused = false
		$PauseScreen.visible = false

