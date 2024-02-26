extends CharacterBody2D
#todo: add dash+wall jump, set animations

#init variables
@export var maxSpeed = 200
@export var accel = 1500
@export var deccel = 2000

#@export var gravity = 20
@export var fallSpeed = 600

@export var gravity_mod = 0
@export var jumpForce = -425
@export var d_jumpForce = -400
@export var v_jump_min = 0.40
@export var coyoteTime = 4

@export var d_jumps = 1

@onready var animated_sprite = $player_sprite

var d_jump_count = 1
var has_jumped = false
var coyoteTimer = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") + gravity_mod

func reset():
	#reset jumps and timers
	if is_on_floor():
		d_jump_count = 0
		coyoteTimer = 0
		has_jumped = false
func apply_gravity(delta):
	#apply gravity and set fall speed cap. Handle Coyote timer
	if not is_on_floor():
		coyoteTimer += 1
		velocity.y += gravity * delta
		if velocity.y > fallSpeed:
			velocity.y = fallSpeed
func handle_jump():
	#main jump + coyoteTime
	if Input.is_action_just_pressed("jump") && (is_on_floor() or coyoteTimer <= coyoteTime) && has_jumped == false:
		velocity.y = jumpForce
		has_jumped = true
	elif Input.is_action_just_released("jump") && !is_on_floor():
		velocity.y = velocity.y * v_jump_min
	#double jump
	if Input.is_action_just_pressed("jump") && !is_on_floor() && coyoteTimer > coyoteTime:
		if d_jump_count <= (d_jumps - 1):
			velocity.y = d_jumpForce
			d_jump_count += 1
func handle_accel(axis, delta):
	if axis != 0:
		velocity.x = move_toward(velocity.x, maxSpeed * axis, accel * delta)
	if axis < 0:
		$player_sprite.flip_h = true
func handle_deccel(axis, delta):
	if axis == 0:
		velocity.x = move_toward(velocity.x, 0, deccel * delta)
func handle_animations(axis):
	if axis > 0:
		$player_sprite.flip_h = false
	if axis < 0:
		$player_sprite.flip_h = true
	if axis == 0 && is_on_floor() == true: 
		$player_sprite.animation = "idle"
	if (axis > 0 or axis < 0) && is_on_floor():
		$player_sprite.animation = "walk"
	$player_sprite.play()

#builtin physics function, updates 60 times per second
func _physics_process(delta):
	reset()
	apply_gravity(delta)
	handle_jump()
	var Input_axis = Input.get_axis("move_left", "move_right")
	handle_accel(Input_axis, delta)
	handle_deccel(Input_axis, delta)
	handle_animations(Input_axis)
	#apply physics and report values for debugging
	move_and_slide()
	print("velocity = " + str(velocity))
	print("coyote time = " + str(coyoteTimer))
