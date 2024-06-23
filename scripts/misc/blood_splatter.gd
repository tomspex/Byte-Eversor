extends RigidBody3D

const HEAL_AMOUNT = 1.0

@onready var blood = $Blood

func _on_body_entered(body):
	if body.is_in_group("player"):
		if body.has_method("heal"):
			body.heal(HEAL_AMOUNT)
			queue()
