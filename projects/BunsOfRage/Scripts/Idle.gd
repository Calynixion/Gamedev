extends State
class_name Idle

func Enter():
	define_player()
	animator.play("k_idle")

func Exit():
	pass

func Update(_delta:float):
	player.friction()
	if player.direction != 0:
		state_transition.emit(self, "run")
	if Input.is_action_just_pressed("jump") && player.can_jump == true:
		state_transition.emit(self, "jump")
	if !player.is_on_floor() && player.velocity.y >= 0:
		state_transition.emit(self, "fall")
	if Input.is_action_just_pressed("dash") && (player.dash_count < player.dashes) && player.can_dash == true:
		state_transition.emit(self, "dash")
