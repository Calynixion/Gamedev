extends CharacterBase
class_name PlayerMain
#todo: add dash+wall jump, set animations

#init variables
@export var maxSpeed = 200
@export var accel = 1500
@export var deccel = 2500

#@export var gravity = 20
@export var fallSpeed = 600

@export var gravity_mod = 0
@export var jumpForce = -425
@export var d_jumpForce = -400
@export var v_jump_min = 0.40
@export var coyoteTime = 6

@export var d_jumps = 1

var d_jump_count = 1
var has_jumped = false
var coyoteTimer = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") + gravity_mod
var Input_axis = 0

func apply_gravity(delta):
	#apply gravity and set fall speed cap. Handle Coyote timer
	if !is_on_floor():
		coyoteTimer += 1
		velocity.y += gravity * delta
		if velocity.y > fallSpeed:
			velocity.y = fallSpeed
func reset():
	#reset jumps and timers
	if is_on_floor():
		d_jump_count = 0
		coyoteTimer = 0
		has_jumped = false
func move(axis, delta):
	if axis != 0:
		velocity.x = move_toward(velocity.x, maxSpeed * axis, accel * delta)
		if axis > 0:
			$player_sprite.flip_h = false
		elif axis < 0:
			$player_sprite.flip_h = true
	if axis == 0:
		velocity.x = move_toward(velocity.x, 0, deccel * delta)


@onready var fsm = $FSM as FiniteStateMachine

func _process(_delta):
	Input_axis = Input.get_axis("move_left", "move_right")
	print("velocity = " + str(velocity))
	print("coyote time = " + str(coyoteTimer))
	print("state = " + str($FSM.current_state))

func get_state():
	return $FSM.current_state
