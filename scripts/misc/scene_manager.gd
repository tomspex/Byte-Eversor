extends Node

var paused = false
@onready var pause_menu = $PauseMenu
@onready var animation_player = $AnimationPlayer

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	$PauseMenu/Continue.grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func toggle_pause():
	if paused: 
		pause_menu.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED 
	else: 
		pause_menu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	paused = !paused
	get_tree().paused = paused

func change_scene(target: String):
	animation_player.play("fade")
	await(animation_player.animation_finished)
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("fade")

func _exit():
	get_tree().quit()
