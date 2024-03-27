extends State

func Enter():
	define_player()
	animator.play("k_fall")
	
func Update(_delta:float):
	player.move()
	player.friction()
	if player.did_jump == false: 
		if Input.is_action_just_pressed("jump") && (player.current_jumps + 1 < player.jumps) && player.can_jump == false:
			state_transition.emit(self, "d_jump")
	if player.did_jump == true: 
		if Input.is_action_just_pressed("jump") && (player.current_jumps < player.jumps) && player.can_jump == false:
			state_transition.emit(self, "d_jump")
	if Input.is_action_just_pressed("jump")  && player.can_jump == true:
		state_transition.emit(self, "jump")
	if player.direction == 0 && player.is_on_floor():
		state_transition.emit(self, "idle")
	if player.direction != 0 && player.is_on_floor():
		state_transition.emit(self, "run")
	if Input.is_action_just_pressed("dash") && (player.dash_count < player.dashes) && player.can_dash == true:
		state_transition.emit(self, "dash")
