extends State

func Enter():
	define_player()
	
func Update(_delta:float):
	if Input.is_action_just_pressed("attack") && player.can_attack == true:
		state_transition.emit(self, "attack")
