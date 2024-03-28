extends State
@export var coyote_timer : Timer

func Enter():
	define_player()
	coyote_timer.start()

func Update(delta:float):
	if player.floating == false:
		player.velocity.y += player.gravity * delta
	if player.velocity.y > player.fall_limit:
		player.velocity.y = player.fall_limit
	if player.is_on_floor():
		state_transition.emit(self, "floor")
