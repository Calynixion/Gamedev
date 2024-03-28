extends State

@export var actions : AnimationPlayer
@export var attack_cooldown : Timer

func Enter():
	define_player()
	if player.facing_r == true:
		actions.play("attack_r")
	if player.facing_r == false:
		actions.play("attack_l")
	player.can_attack = false
	attack_cooldown.start()

func Update(_delta:float):
	if actions.is_playing() == false:
		state_transition.emit(self, "null")
