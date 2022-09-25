extends KinematicBody

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var mouse_sensitivity = 0.005
export var vertical_fov = PI / 4

var velocity = Vector3.ZERO
var camera_x_rotation = 0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		$Head.rotate_y(-event.relative.x * mouse_sensitivity)
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -vertical_fov / 2 and camera_x_rotation + x_delta < vertical_fov:
			$Head/Camera.rotate_x(-x_delta)
			camera_x_rotation += x_delta

func _physics_process(delta):
	var head_basis = $Head.global_transform.basis
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_back"):
		direction += head_basis.z
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y -= gravity
	velocity = move_and_slide(velocity, Vector3.UP)
