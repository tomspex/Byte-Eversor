extends Control

signal _return

@onready var options_menu = $OptionsMenu

func load_menu(scene_file):
	options_menu.hide()
	var menu_instance = load(scene_file).instantiate()
	add_child(menu_instance)
	menu_instance._return.connect(options_menu.show)

func _on_return_pressed():
	_return.emit()
	queue_free()

func _on_video_pressed():
	load_menu("res://scenes/gui/video.tscn")
