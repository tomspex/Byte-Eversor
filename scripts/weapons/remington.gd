extends Node3D

#weapon stats
const DAMAGE = 20

@export var spread = 10

@onready var cooldown = $Cooldown
@onready var raycasts = $Raycasts
#@onready var animator = $Animator
@onready var fire_sfx = $SFX/Fire

func _ready():
	print("SHOTGUN TIME!!!")
	
	randomize()
	randomize_raycasts()

func fire():
	if !cooldown.is_stopped():
		return
	
	print("BAM!!!")
	
	randomize_raycasts()
	for r in raycasts.get_children():
		if r.is_colliding():
			var collider = r.get_collider()
			var collider_normal = r.get_collision_normal()
			var collider_point = r.get_collision_point()
			
			var bullet_hole_decal_instance = Weapons.bullet_hole_decal.instantiate()
			collider.add_child(bullet_hole_decal_instance)
			bullet_hole_decal_instance.transform.origin = collider_point + collider_normal * 0.001
			bullet_hole_decal_instance.look_at(collider_point + collider_normal, Vector3.UP)
			
			if collider.has_method("damage"):
				collider.damage(DAMAGE)
	
	#animator.stop()
	#animator.play("fire")
	
	fire_sfx.stop()
	fire_sfx.play()
	
	cooldown.start()

func aim_from(target_position:Vector3):
	for r in raycasts.get_children():
		r.global_position = target_position

func randomize_raycasts():
	for r in raycasts.get_children():
		r.rotation.x = deg_to_rad(randf_range(spread, -spread))
		r.rotation.y = deg_to_rad(randf_range(spread, -spread))
