extends Sprite2D

func _process(_delta):
	if Input.is_action_pressed("move_left"):
		flip_h = true
	if Input.is_action_pressed("move_right"):
		flip_h = false
