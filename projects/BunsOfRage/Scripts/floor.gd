extends State

func Enter():
	define_player()
	player.current_jumps = 0
	player.can_jump = true
	player.did_jump = false

func Exit():
	pass
	
func Update(_delta:float):
	if player.can_dash == true:
		player.dash_count = 0
	if !player.is_on_floor():
		state_transition.emit(self, "air")
