extends Node2D

@export var characters : Node
var location = Vector2(448, 0)
var current_bar = 0
@onready var collection = $collection
var queue_bar = preload("res://Scenes/queue_bar.tscn")

func _ready():
	pass

func _process(_delta):
	update_bars()
	for child in $collection.get_children():
		child.characters = characters


func create_bar(id):
	var instance = queue_bar.instantiate()
	instance.set_bar(id)
	$collection.add_child(instance)
	
	


func update_bars():
	for child in (characters.get_children()):
		for indicator_bar in collection.get_children():
			if child.id == indicator_bar.id:
				if child.is_angry == true:
					indicator_bar.on_angry()
				if child.healed == true:
					indicator_bar.on_heal()

