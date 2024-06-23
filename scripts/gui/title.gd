extends Control

var _NOPAUSE = true

func _on_start_pressed():
	SceneManager.change_scene("res://scenes/maps/episode_1/map_1.tscn")

func _on_exit_pressed():
	get_tree().quit()
