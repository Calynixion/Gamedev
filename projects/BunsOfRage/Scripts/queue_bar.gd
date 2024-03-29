extends Node2D

@export var id = 0
var characters

func _process(_delta):
	for child in characters.get_children():
		if child.id == id:
			update_timer(child)


func update_timer(child):
	$time.text = str("%4.1f" % child.anger_timer.time_left)

func on_angry():
	$indicator.color = Color("#ff0000")

func on_heal():
	$indicator.visible = false
	$time.visible = false

func set_bar(character_id):
	id = character_id
	position.x = 448 + (64 * character_id)
	name = str(character_id)
