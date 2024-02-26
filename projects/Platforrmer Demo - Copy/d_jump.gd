extends State

var player : CharacterBody2D
@export var animator : AnimationPlayer

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	player.velocity.y = player.d_jumpForce
	player.d_jump_count += 1
	animator.play("d_jump")

func Exit():
	pass
	
func Update(delta:float):
	player.move(player.Input_axis, delta)
	player.apply_gravity(delta)
	player.move_and_slide()
	if player.velocity.y > 0:
		state_transition.emit(self, "fall")
	
