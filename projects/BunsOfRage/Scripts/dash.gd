extends State
@export var dash_cooldown : Timer
@export var dash_float : Timer
var d_jump_buffer = false
var timer_up = false
@onready var buffer_timer = $"../../d_jump_dash_buffer"

func Enter():
	define_player()
	animator.play("k_dash")
	player.velocity.y = 0
	if player.facing_r == true:
		player.velocity.x = player.dash_velocity * 1
	if player.facing_r == false:
		player.velocity.x = player.dash_velocity * -1
	player.floating = true
	player.dir_locked = true
	player.dash_count += 1
	player.can_dash = false
	dash_cooldown.start()
	buffer_timer.start()
	timer_up = false

func Update(_delta:float):
	if timer_up == true:
		if Input.is_action_just_pressed("jump") && !player.is_on_floor():
			d_jump_buffer = true
	if animator.is_playing() == false:
		if d_jump_buffer == true:
			state_transition.emit(self, "d_jump")
		if player.direction == 0 && player.is_on_floor():
			state_transition.emit(self, "idle")
		if player.direction != 0 && player.is_on_floor():
			state_transition.emit(self, "run")
		if !player.is_on_floor():
			state_transition.emit(self, "fall")

func Exit():
	d_jump_buffer = false
	timer_up = false
	player.normalize()
	dash_float.start()
	player.dir_locked = false


func _on_d_jump_dash_buffer_timeout():
	timer_up = true
	buffer_timer.stop()
