extends Node3D

@export var scene : String

func interact():
	SceneManager.change_scene(scene)
