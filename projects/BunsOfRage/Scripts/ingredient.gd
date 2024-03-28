extends Area2D

@export var player : CharacterBody2D


func _ready():
	enable()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func disable():
	monitorable = false
	$sprite.visible = false
	$collision.disabled = true

func enable():
	monitorable = true
	$sprite.visible = true
	$collision.disabled = false


func _on_body_entered(body):
	player.has_item = true
	disable()
