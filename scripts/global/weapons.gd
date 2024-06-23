extends Node

var bullet_hole_decal = preload("res://scenes/misc/bullet_hole_decal.tscn")

enum {
	COLT = 0,
	REMINGTON = 1
}

const weapons = [
	{
		"name": "Colt 1911",
		"scene": "res://scenes/weapons/colt.tscn",
		"position": Vector3(0.437, -0.44, -1)
	},
	{
		"name": "Remington 870",
		"scene": "res://scenes/weapons/remington.tscn",
		"position": Vector3(0.33, -0.3, -0.985)
	}
]
