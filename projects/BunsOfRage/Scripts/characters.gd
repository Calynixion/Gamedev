extends Node

var character = preload("res://Scenes/character.tscn")
@export var bars : Node
var current_id = 0
var max_characters = 5
var done = false

func _ready():
	while current_id < max_characters:
		create_character(current_id)
		bars.create_bar(current_id)
		current_id += 1

func _process(_delta):
	if current_id < max_characters:
		create_character(current_id)
		bars.create_bar(current_id)
		current_id += 1

func create_character(id):
	add_child(character.instantiate())
	for child in get_children():
		if child.name == "character":
			child.name = str(id)
			child.id = id
	
