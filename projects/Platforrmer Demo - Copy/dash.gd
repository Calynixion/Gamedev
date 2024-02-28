extends State

var player : CharacterBody2D
@export var animator : AnimationPlayer

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	if player.Input_axis > 0:
		player.velocity.x += 500
	elif player.Input_axis < 0:
		player.velocity.x -= 500

func Exit():
	pass

func Update(delta:float):
	state_transition.emit(self, "run")
