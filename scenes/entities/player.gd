extends CharacterBody3D

#input properties
#NOTE: might wanna move this to a global script
const MOUSE_SENSITIVITY = 0.01
const KEY_SENSITIVITY = 0.05

#movement properties
var speed = 0.0
const WALK_SPEED = 15.0
const SPRINT_SPEED = 25.0
const FRICTION = 6.0
const JUMP_VELOCITY = 15
const POUND_VELOCITY = -100
const MASS = 2

#bob properties
const BOB_FREQ = 1.0
const BOB_AMP = 0.1
var t_bob = 0.0

#fov properties
const BASE_FOV = 75.0
const FOV_AMP = 1.0

#global properties (why can't this be a const)
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#linked nodes
@onready var camera = $Head/Camera

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
		camera.rotation.y = clamp(camera.rotation.y, -PI/2, PI/2)

func _physics_process(delta):  
	if not is_on_floor():
		velocity.y -= gravity * delta * MASS
	
	#get special key inputs
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("pound") and !is_on_floor():
		velocity.y = POUND_VELOCITY
		velocity.x = 0
		velocity.z = 0
	
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	#get directional input and set velocity
	var input_dir = Input.get_vector("strafe_left", "strafe_right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor() and direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * FRICTION)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * FRICTION)
	
	var camera_dir = Input.get_vector("turn_left", "turn_right", "turn_up", "turn_down")
	camera.rotate_x(-camera_dir.y * MOUSE_SENSITIVITY)
	rotate_y(-camera_dir.x * KEY_SENSITIVITY)
	
	#bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _head_bob(t_bob)
	
	#fov
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_AMP * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)

	move_and_slide()

func _head_bob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	return pos
