extends Label

var player : CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _process(_delta):
	text = ""
	text += "Velocity: " + str(player.velocity)
