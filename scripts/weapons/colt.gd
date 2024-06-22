extends Node3D

#weapon stats
const DAMAGE = 40

@export var players = false

@onready var cooldown = $Cooldown
@onready var raycast = $Raycast
@onready var animator = $Animator
@onready var fire_sfx = $SFX/Fire

func _ready():
	print("WE'RE PISTOLING!!!")
	
	if players:
		for m in $Model.get_children():
			m.set_layer_mask_value(1, false)
			m.set_layer_mask_value(2, true)

func fire():
	if !cooldown.is_stopped():
		return
	
	print("PEW!!!")
	
	animator.stop()
	animator.play("fire")
	
	fire_sfx.stop()
	fire_sfx.play()
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		var collider_normal = raycast.get_collision_normal()
		var collider_point = raycast.get_collision_point()
		
		var bullet_hole_decal_instance = Weapons.bullet_hole_decal.instantiate()
		collider.add_child(bullet_hole_decal_instance)
		bullet_hole_decal_instance.transform.origin = collider_point + (collider_normal * 0.01)
		bullet_hole_decal_instance.look_at(collider_point + collider_normal, Vector3.UP)
		
		if collider.has_method("damage"):
			collider.damage(DAMAGE)
	
	cooldown.start()

func aim_from(target_position:Vector3):
	raycast.global_position = target_position
