extends CharacterBody2D


@export var SPEED = 250.0
@export var ACCEL = 1550.0
@export var JUMP_VELOCITY = -400.0
@export var dashspeed = 15
@export var maxdoublejumps = 1
@export var maxdashes = 1

var direction = 1
var jumpsleft
var dashleft
var walkvector = 0
var dashvector = 0
var floating = false
var dashing = false
var candash = true
var placeholdervely


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if floating == false:
			velocity.y += gravity * delta
	else:
		jumpsleft = maxdoublejumps
		dashleft = maxdashes
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("ui_accept") and jumpsleft > 0 and not is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumpsleft -= 1
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if 1 == Input.get_axis("ui_left", "ui_right"):
		direction = 1
	elif -1 == Input.get_axis("ui_left", "ui_right"):
		direction = -1
		
	if Input.get_axis("ui_left", "ui_right"):
		walkvector += direction * ACCEL * delta
	else:
		walkvector = 0
	# Makes sure you dont go over max and min speeds
	if walkvector > SPEED:
		walkvector = SPEED
	elif  walkvector < SPEED*-1:
		walkvector = SPEED*-1
	
	
	#changes your velocity based on walkvector, dosent do this when dashing to account for higher speeds during it.
	velocity.x = walkvector + dashvector
	
	#dashing script
	if Input.is_action_just_pressed("dash") and dashleft > 0:
		if candash:
			velocity.y = 0
			candash = false
			floating = true
			dashleft -= 1
			dashvector += direction * ACCEL * delta * dashspeed
			$CooldownTimer.start() #sets a timer for .2 seconds
			
		
	

	move_and_slide()

#when the dash ends
func _on_cooldown_timer_timeout():
	candash = true
	floating = false
	dashvector = 0
	$CooldownTimer.stop()
