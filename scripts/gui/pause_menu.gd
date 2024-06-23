extends Control

var paused = false

@onready var continue_button = $Continue

func _ready():
	continue_button.grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func toggle_pause():
	if paused: 
		hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED 
	else: 
		show()
		continue_button.grab_focus()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	paused = !paused
	get_tree().paused = paused

func _on_continue_pressed():
	toggle_pause()

func _on_title_screen_pressed():
	SceneManager.change_scene("res://scenes/gui/title.tscn")

func _on_exit_pressed():
	get_tree().quit()
