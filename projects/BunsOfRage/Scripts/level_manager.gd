extends Node

#WARNING! Unstable and may cause crashes. See Comment below
#need to add safeguards.
#make levels randomizable and have a level : number system to clean it up

var level_1 = preload("res://Scenes/level_1.tscn").instantiate()
var level_2 = preload("res://Scenes/level_2.tscn").instantiate()
var level_3 = preload("res://Scenes/level_3.tscn").instantiate()

var level_dict = {
	1 : level_1,
	2 : level_2,
	3 : level_3
}

var initial_level = 1
var current_level = initial_level

func _ready():
	add_child(level_dict[initial_level])

func _process(_delta):
	if Input.is_action_just_pressed("change_level"):
		if current_level != 3:
			change_level(current_level + 1)
			current_level += 1

	
func change_level(new_level):
	level_dict[current_level].queue_free()
	add_child(level_dict[new_level])
