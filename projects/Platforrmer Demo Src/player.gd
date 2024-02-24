extends CharacterBody2D
#todo: fix coyote time, add dash+wall jump, set animations

#init variables
@export var maxSpeed = 210
@export var accel = 30
@export var deccel = 40

@export var gravity = 20
@export var fallSpeed = 600

@export var jumpForce = -425
@export var d_jumpForce = -400
@export var v_jump_min = 0.40
@export var coyoteTime = 4

@export var d_jumps = 1

var d_jump_count = 1
var has_jumped = false
var coyoteTimer = 0

#builtin physics function, updates 60 times per second
func _physics_process(_delta):
	
	#reset jumps and timers
	if is_on_floor():
		d_jump_count = 0
		coyoteTimer = 0
		has_jumped = false
		
	#apply gravity and set fall speed cap. Handle Variable jump timer and cap at max. Handle Coyoyte time
	if !is_on_floor():
		coyoteTimer += 1
		velocity.y += gravity
		if velocity.y > fallSpeed:
			velocity.y = fallSpeed

	#main jump + coyoteTime
	if Input.is_action_just_pressed("jump") && (is_on_floor() or coyoteTimer <= coyoteTime) && has_jumped == false:
		velocity.y = jumpForce
		has_jumped = true

	#double jump
	if Input.is_action_just_pressed("jump") && !is_on_floor() && coyoteTimer > coyoteTime:
		if d_jump_count <= (d_jumps - 1):
			velocity.y = d_jumpForce
			d_jump_count += 1
		
	
	#variable jump, 
	if Input.is_action_just_released("jump") && !is_on_floor():
		velocity.y = velocity.y * v_jump_min
		velocity.y += gravity
		if velocity.y > fallSpeed:
			velocity.y = fallSpeed
		
	#Basic L and R below, commented out
	#var h_direction = Input.get_axis("move_left", "move_right")
	#velocity.x = maxSpeed * h_direction

	#Main L and R
	if Input.is_action_pressed("move_right"):
		$player_sprite.flip_h = false
		velocity.x += accel
		if velocity.x >= maxSpeed:
			velocity.x = maxSpeed

	if Input.is_action_pressed("move_left"):
		$player_sprite.flip_h = true
		velocity.x -= accel
		if velocity.x <= -maxSpeed:
			velocity.x = -maxSpeed

	#set deccelaration
	if not Input.is_action_pressed("move_left") && velocity.x < 0:
		velocity.x += deccel
		if velocity.x > 0:
			velocity.x = 0
	if not Input.is_action_pressed("move_right") && velocity.x > 0:
		velocity.x -= deccel
		if velocity.x < 0:
			velocity.x = 0

	#Make character stand still
	if velocity.x < 4 && velocity.x > -4 && not Input.is_action_pressed("move_left") && not Input.is_action_pressed("move_right"):
		velocity.x = 0
	
	#handle graphics
	
	#ground idle
	if is_on_floor() && not Input.is_action_pressed("move_left") && not Input.is_action_pressed("move_right"):
		$player_sprite.animation = "idle"
		
	#ground L and R
	if Input.is_action_pressed("move_left") && is_on_floor():
		$player_sprite.animation = "walk"
	if Input.is_action_pressed("move_right") && is_on_floor():
		$player_sprite.animation = "walk"

	#jump + fall + d_jump
	if !is_on_floor() && velocity.y > 0 && $player_sprite.current_animation != "fall":
		$player_sprite.animation = "fall"
	if !is_on_floor() && velocity.y <= 0 && $player_sprite.current_animation != "jump":
		$player_sprite.animation = "jump"
	
	
	
	
	
	
	
	
	
	
	
	
	#play animations only if a looping animation is active
	if $player_sprite.animation != "jump" or "fall":
		$player_sprite.play()
	
	#apply changes and report values for debugging
	move_and_slide()
	print("velocity = " + str(velocity))
	print("coyote time = " + str(coyoteTimer))
