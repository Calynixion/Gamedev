extends Area2D

var player : CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player.respawn()
