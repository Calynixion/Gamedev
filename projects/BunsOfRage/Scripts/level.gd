extends Node2D


@export var level_manager : Node
@export var characters : Node
@export var player :CharacterBody2D
@export var main : Node

var num_children
var num_angry
var num_done
var num_healed

var count = 0
var count_1 = 0
var count_2 = 0
var count_3 = 0

func _ready():
	pass

func _process(_delta):
	check_children()
	check_heal()
	check_done()
	check_angry()
	check_lose()
	$level.text = ""
	$level.text += "level: " + str(level_manager.current_level)
	$item.text = ""
	$item.text = "Item Id: " + str(player.item_id)
	$total.text = ""
	$total.text = "To lose: " + str(num_angry) + "/" + str(num_children - num_done)
	$healed.text = ""
	$healed.text = "Healed: " + str(num_healed)

func check_children():
	for child in characters.get_children():
		count += 1
	num_children = count
	count = 0

func check_done():
	for child in characters.get_children():
		if child.done == true:
			count_1 += 1
	num_done = count_1
	count_1 = 0

func check_angry():
	for child in characters.get_children():
		if child.is_angry == true:
			count_2 += 1
	num_angry = count_2
	count_2 = 0

func check_heal():
	for child in characters.get_children():
		if child.healed == true:
			count_3 += 1
	num_healed = count_3
	count_3 = 0

func check_lose():
	if (num_angry) >= (num_children - num_done):
		main.lose()
