extends AnimationPlayer

var player : CharacterBody2D
@onready var player_sprite = $"../player_sprite"
@onready var wings_sprite = $"../wings"

func _ready():
	player = get_tree().get_first_node_in_group("Player")


func _process(_delta):
	if player.dir_locked == false:
		if Input.is_action_pressed("move_left"):
			player_sprite.flip_h = true
			wings_sprite.flip_h = true
		if Input.is_action_pressed("move_right"):
			player_sprite.flip_h = false
			wings_sprite.flip_h = false
