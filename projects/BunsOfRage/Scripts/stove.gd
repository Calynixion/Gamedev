extends Area2D

@export var player : CharacterBody2D
@export var item : Area2D

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	if body.is_in_group("Player") && player.has_item == true:
		player.score += 1
		player.has_item = false
		item.enable()
