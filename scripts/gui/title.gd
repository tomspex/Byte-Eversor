extends Control

var _NOPAUSE = true

@onready var main_menu = $MainMenu

func _on_start_pressed():
	SceneManager.change_scene("res://scenes/maps/episode_1/map_1.tscn")

func _on_options_pressed():
	main_menu.hide()
	var options_instance = load("res://scenes/gui/options.tscn").instantiate()
	add_child(options_instance)
	options_instance._return.connect(main_menu.show)

func _on_exit_pressed():
	get_tree().quit()
