extends Area2D

@export var player : CharacterBody2D
@export var id = 1

func _ready():
	enable()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func disable():
	set_deferred("monitorable", false)
	$sprite.set_deferred("visible", false)
	$collision.set_deferred("disabled", true)

func enable():
	set_deferred("monitorable", true)
	$sprite.set_deferred("visible", true)
	$collision.set_deferred("disabled", false)


func _on_body_entered(body):
	if body.is_in_group("Player"):
		player.has_item = true
		player.item_id = id
		disable()
