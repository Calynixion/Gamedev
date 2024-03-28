extends State

func Enter():
	define_player()
	if player.current_jumps < player.jumps:
		player.velocity.y = -player.jump_velocity
		player.current_jumps += 1
		player.did_jump = true
	animator.play("k_jump")

func Update(_delta:float):
	if Input.is_action_just_released("jump"):
		player.velocity.y = player.velocity.y * player.jump_min
	player.move()
	player.friction()
	if Input.is_action_just_pressed("jump") && (player.current_jumps < player.jumps) && player.can_jump == false:
		state_transition.emit(self, "d_jump")
	if player.velocity.y > 0:
		state_transition.emit(self, "fall")
	if player.direction == 0 && player.is_on_floor():
		state_transition.emit(self, "idle")
	if player.direction != 0 && player.is_on_floor():
		state_transition.emit(self, "run")
	if Input.is_action_just_pressed("dash") && (player.dash_count < player.dashes) && player.can_dash == true:
		state_transition.emit(self, "dash")
