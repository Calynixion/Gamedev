extends Node2D

@export var characters : Node

@export var id = 0

@onready var bar = $bar
@onready var timer = $timer
@onready var order = $order
var done = false

func _process(_delta):
	for child in characters.get_children():
		if child.id == id:
			enable()
			update_timer(child)
			update_bar(child)
			update_order(child)
			if child.done == true:
				done = true
				id += 1


func update_timer(child):
	timer.text = "Time Left: " + str("%4.1f" % child.anger_timer.time_left)
func update_bar(child):
	if child.is_angry == true:
		bar.color = Color("#ff0000")
	if child.is_angry == false:
		bar.color = Color("#00ff00")
func update_order(child):
	order.text = str(child.order)

func disable():
	visible = false
func enable():
	visible = true
