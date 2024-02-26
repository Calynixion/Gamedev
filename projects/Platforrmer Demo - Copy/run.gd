extends State
class_name PlayerWalking

var player : CharacterBody2D
@export var animator : AnimationPlayer

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	animator.play("run")
	
func Exit():
	pass
	
func Update(delta:float):
	player.move(player.Input_axis, delta)
	player.apply_gravity(delta)
	player.move_and_slide()
	if Input.is_action_just_pressed("jump") && player.is_on_floor()  && (player.is_on_floor() or player.coyoteTimer <= player.coyoteTime) && player.has_jumped == false:
		state_transition.emit(self, "jump")
	if player.Input_axis == 0 && player.is_on_floor:
		state_transition.emit(self, "idle")
	if player.velocity.y > 0:
		state_transition.emit(self, "fall")
	


