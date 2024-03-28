extends CharacterBody2D

@export var animator : AnimationPlayer

var speed = 450
var accel = 75
var deccel = 115

var jump_velocity = 1000
var jump_min = 0.4
var jumps = 2
var current_jumps = 0
var can_jump = true
var did_jump = false

var gravity = 2500
var fall_limit = 1200

var states = ["null", "null"]
var environment = states[0]
var movement = states[1]

var direction = 0
var facing_r = true 

var speed_diff = 0
var modifier = 0

var dash_velocity = 750
var dashes = 1
var dash_count = 0
var can_dash = true

var floating = false
var dir_locked = false

var has_item = false
var score = 0

func _physics_process(_delta):
	direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		facing_r = true
	if direction < 0:
		facing_r = false
	update_states()
	move_and_slide()
	print(velocity)
	print(has_item)

func update_states():
	environment = $environment.current_state
	movement = $movement.current_state

	states[0] = environment
	states[1] = movement

func move():
	if direction > 0:
		speed_diff = (speed - velocity.x)/(speed)
	if direction < 0:
		speed_diff = (-speed - velocity.x)/(speed)

	if speed_diff < 0.05:
		speed_diff = 1
	
	modifier = accel * speed_diff
	
	velocity.x += modifier * direction
	
	if velocity.x > speed:
		velocity.x = speed
	elif velocity.x < -speed:
		velocity.x = -speed
	
func friction():
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, deccel)
		
func normalize():
	if direction > 0:
		if velocity.x > speed:
			velocity.x = speed
	if direction < 0:
		if velocity.x < -speed:
			velocity.x = -speed
			

func _on_dash_cooldown_timeout():
	$dash_cooldown.stop()
	can_dash = true


func _on_dash_float_timeout():
	floating = false
	$dash_float.stop()


func _on_coyote_timer_timeout():
	can_jump = false
	$coyote_timer.stop()
