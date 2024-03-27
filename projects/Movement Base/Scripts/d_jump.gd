extends State

func Enter():
	define_player()
	player.velocity.y = -player.jump_velocity
	player.current_jumps += 1
	animator.play("k_d_jump")

func Update(_delta:float):
	player.move()
	player.friction()
	if player.did_jump == false: 
		if Input.is_action_just_pressed("jump") && (player.current_jumps + 1 < player.jumps) && player.can_jump == false:
			player.velocity.y = -player.jump_velocity
			player.current_jumps += 1
			animator.play("k_d_jump")
	if player.did_jump == true: 
		if Input.is_action_just_pressed("jump") && (player.current_jumps < player.jumps) && player.can_jump == false:
			player.velocity.y = -player.jump_velocity
			player.current_jumps += 1
			animator.play("k_d_jump")
	if player.velocity.y > 0:
		state_transition.emit(self, "fall")
	if player.direction == 0 && player.is_on_floor():
		state_transition.emit(self, "idle")
	if player.direction != 0 && player.is_on_floor():
		state_transition.emit(self, "run")
	if Input.is_action_just_pressed("dash") && (player.dash_count < player.dashes) && player.can_dash == true:
		state_transition.emit(self, "dash")

func Exit():
	$"../../wings".visible = false
