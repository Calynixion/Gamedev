extends Area2D

@export var player : CharacterBody2D
@export var ingredients : Node
@export var characters : Node

var order
var current_item

func _ready():
	reset()

func _process(_delta):
	$order.text = str(order)

func _on_body_entered(body):
	if body.is_in_group("Player") && player.has_item == true:
		order[current_item] = player.item_id
		player.score += 1
		player.has_item = false
		player.item_id = 0
		for child in ingredients.get_children():
			child.enable()
		if current_item == 2:
			check_orders()
			reset()
		else:
			current_item += 1

func reset():
	order = [0, 0, 0]
	current_item = 0

func check_orders():
	for child in characters.get_children():
		if child.order == order:
			player.score += 5
			if child.is_angry == true:
				child.is_angry = false
				child.healed = true
			child.is_angry = false
			child.done = true
