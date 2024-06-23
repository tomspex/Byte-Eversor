extends Node

@onready var animation_player = $AnimationPlayer

func change_scene(target: String):
	animation_player.play("fade")
	await(animation_player.animation_finished)
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("fade")
