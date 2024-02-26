extends State

var player : CharacterBody2D
@export var animator : AnimationPlayer

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	animator.play("fall")
	
func Exit():
	pass
	
func Update(delta:float):
	player.move(player.Input_axis, delta)
	player.apply_gravity(delta)
	player.move_and_slide()
	if player.is_on_floor() == true:
		state_transition.emit(self, "idle")
	if Input.is_action_just_pressed("jump") && !player.is_on_floor() && player.coyoteTimer > player.coyoteTime && player.d_jump_count <= (player.d_jumps - 1):
		state_transition.emit(self, "d_jump")
	
