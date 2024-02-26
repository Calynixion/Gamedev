extends State

var player : CharacterBody2D
@export var animator : AnimationPlayer

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	handle_jump()
	animator.play("jump")

func Exit():
	pass
	
func Update(delta:float):
	if Input.is_action_just_released("jump") && !player.is_on_floor() && player.velocity.y < 0:
		player.velocity.y = player.velocity.y * player.v_jump_min
	player.move(player.Input_axis, delta)
	player.apply_gravity(delta)
	player.move_and_slide()
	if player.is_on_floor() == true:
		state_transition.emit(self, "idle")
	if Input.is_action_just_pressed("jump") && !player.is_on_floor() && player.coyoteTimer > player.coyoteTime && player.d_jump_count <= (player.d_jumps - 1):
		state_transition.emit(self, "d_jump")
	if player.velocity.y > 0:
		state_transition.emit(self, "fall")
	
	

func handle_jump():
	#main jump + coyoteTime
	player.velocity.y = player.jumpForce
	player.has_jumped = true

