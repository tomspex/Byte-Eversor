extends Node

@onready var animation_player = $AnimationPlayer
@onready var quantization = $CanvasLayer/Quantization

func change_scene(target: String):
	animation_player.play("fade")
	await(animation_player.animation_finished)
	get_tree().paused = false
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("fade")

func set_quantization(amount : int):
	quantization.material.set_shader_parameter("amount", amount)
